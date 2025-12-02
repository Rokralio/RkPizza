# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Define la ruta raíz ("/") para el constructor de pizzas
  root 'pizza_builder#index'

  # RUTAS DE GESTIÓN DE PEDIDOS
  # Crea las rutas básicas: POST /orders, GET /orders, GET /orders/:id
  resources :orders, only: %i[create index show] do
    # Añadimos una ruta PATCH anidada para actualizar el estado por ID de pedido
    # Se mapea a PATCH /orders/:id/update_status y usa OrdersController#update_status
    patch 'update_status', on: :member
  end
end
