# frozen_string_literal: true

# app/helpers/auth_helper.rb
module AuthHelper
  # Verifica si el usuario actual es el administrador logueado.
  def admin_logged_in?
    # El método 'authenticate_admin' ya se encarga de pedir las credenciales.
    # Aquí, simplemente verificamos si la cabecera de autenticación HTTP Basic está presente.
    if request.authorization.present?
      # Si hay cabecera de autenticación, se asume que el navegador ya la envió y fue exitosa.
      true
    else
      false
    end
  end
end
