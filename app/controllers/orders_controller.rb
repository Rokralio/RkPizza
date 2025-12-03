# frozen_string_literal: true

class OrdersController < ApplicationController
  include AdminAuth # <-- ¡AÑADIDO!

  # La acción 'create' (para el cliente al hacer un pedido) NO necesita autenticación.
  skip_before_action :authenticate_admin, only: [:create] # <-- ¡AÑADIDO!

  # Deshabilitamos la protección CSRF para la acción create.
  skip_before_action :verify_authenticity_token, only: [:create]

  # POST /orders (Usado por el cliente/constructor de pizzas)
  def create
    # 1. Obtener los parámetros permitidos
    permitted_params = order_params

    # 2. Extraemos los datos necesarios para construir la pizza y los separamos de los datos de la Orden
    #    (.delete elimina la clave del hash permitted_params y nos devuelve el valor)
    base_id = permitted_params.delete(:base_id)
    ingredient_ids = permitted_params.delete(:ingredient_ids) || []
    pizza_size = permitted_params.delete(:size) # <--- ¡Aquí capturamos el tamaño!

    # 3. Iniciar una transacción de base de datos
    ActiveRecord::Base.transaction do
      # Crea la Orden (Pedido)
      # Nota: permitted_params ahora solo contiene :table_number y :total_price porque borramos el resto arriba
      @order = Order.new(permitted_params)
      @order.status = :pending # Forzamos el estado inicial si no viene por defecto en la BD
      @order.save!

      # Crea la Pizza (asociada a la Orden y la Base)
      @pizza = @order.pizzas.build(
        base_id: base_id,
        size: pizza_size, # <--- ¡Aquí asignamos el tamaño a la pizza!
        name: "Personalizada - Mesa #{@order.table_number}",
      )
      @pizza.save!

      # Crea las uniones PizzaIngredient
      ingredient_ids.each do |ingredient_id|
        @pizza.pizza_ingredients.create!(ingredient_id: ingredient_id)
      end
    end

    # Si la transacción es exitosa
    render(json: { success: true, order_id: @order.id, message: "Pedido enviado con éxito. ¡Mesa #{@order.table_number}!" }, status: :created)
  rescue ActiveRecord::RecordInvalid => e
    # Si la transacción falla (ej. por validación o error), se revierte todo
    render(json: { success: false, errors: e.record.errors.full_messages.join(', ') }, status: :unprocessable_entity)
  rescue StandardError => e
    render(json: { success: false, errors: "Error desconocido al procesar el pedido: #{e.message}" }, status: :internal_server_error)
  end

  # GET /orders (Muestra la lista de pedidos para la gestión)
  def index
    # Muestra los pedidos, priorizando los pendientes (0) y en progreso (1)
    # y ordenándolos por fecha de creación (los más recientes primero)
    @orders = Order.order(status: :asc, created_at: :desc)
  end

  # GET /orders/:id (Muestra los detalles de un solo pedido)
  def show
    @order = Order.find(params[:id])
  end

  # PATCH /orders/:id/update_status (Ruta personalizada para cambiar el estado)
  def update_status
    @order = Order.find(params[:id])

    # Intenta actualizar el estado usando el valor del parámetro (ej. 'in_progress' o 'completed')
    if @order.update(status: params[:new_status])
      # Usamos `orders_path` para redirigir a la lista de pedidos después de la actualización
      redirect_to(orders_path, notice: "El estado del pedido ##{@order.id} ha sido actualizado a '#{@order.status.humanize}'.")
    else
      # Si falla la actualización (ej. validación), redirige con una alerta
      redirect_to(orders_path, alert: 'No se pudo actualizar el estado del pedido.')
    end
  rescue ActiveRecord::RecordNotFound
    # Si el pedido no existe, redirige con una alerta
    redirect_to(orders_path, alert: 'Pedido no encontrado.')
  end

  private

  def order_params
    # Permitimos recibir un objeto con los datos de la orden y la pizza, incluyendo :size
    params.require(:order).permit(:table_number, :total_price, :base_id, :size, ingredient_ids: [])
  end
end
