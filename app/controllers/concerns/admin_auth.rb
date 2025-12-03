# frozen_string_literal: true

module AdminAuth
  extend ActiveSupport::Concern

  included do
    # Este método se ejecutará antes de cualquier acción en los controladores que lo incluyan
    before_action :authenticate_admin
  end

  private

  def authenticate_admin
    # Solicitamos credenciales de autenticación HTTP básica
    authenticate_or_request_with_http_basic('Administración RKpizza') do |username, password|
      # Credenciales: usuario 'admin', contraseña 'secreto'
      username == 'admin' && password == 'password'
    end
  end
end
