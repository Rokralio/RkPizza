# frozen_string_literal: true

class BasesController < ApplicationController
  include AdminAuth

  before_action :set_basis, only: %i[show edit update destroy]

  # ACCIÓN DE LOGOUT: Solo fuerza el popup 401.
  def admin_logout
    # Forzamos la falla de autenticación. Esto es lo que activa el popup 401.
    authenticate_or_request_with_http_basic('Administración RKpizza') do |_, _|
      false # Devuelve false
    end

    # ¡IMPORTANTE! No ponemos ninguna línea de render o redirect aquí.
    # El helper 'authenticate_or_request_with_http_basic' maneja la respuesta 401
    # y termina la acción implícitamente si falla.
    # El JavaScript se encarga de la redirección.
  end

  # GET /bases or /bases.json
  def index
    @bases = Base.all
  end
  # ... (resto de acciones CRUD) ...

  # GET /bases/1 or /bases/1.json
  def show
  end

  # GET /bases/new
  def new
    @basis = Base.new
  end

  # GET /bases/1/edit
  def edit
  end

  # POST /bases or /bases.json
  def create
    @basis = Base.new(basis_params)

    respond_to do |format|
      if @basis.save
        format.html { redirect_to(@basis, notice: 'Base was successfully created.') }
        format.json { render(:show, status: :created, location: @basis) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @basis.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /bases/1 or /bases/1.json
  def update
    respond_to do |format|
      if @basis.update(basis_params)
        format.html { redirect_to(@basis, notice: 'Base was successfully updated.', status: :see_other) }
        format.json { render(:show, status: :ok, location: @basis) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @basis.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /bases/1 or /bases/1.json
  def destroy
    @basis.destroy!

    respond_to do |format|
      format.html { redirect_to(bases_path, notice: 'Base was successfully destroyed.', status: :see_other) }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_basis
    @basis = Base.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def basis_params
    params.require(:basis).permit(:name, :price, :description, :image_url)
  end
end
