class Users::SessionsController < Devise::SessionsController
  # Перехватываем попытку входа (до валидации)
  def create
    
    # Выполняем стандартную логику Devise
    super
  end

  # Перехватываем успешный вход
  def after_sign_in_path_for(resource)
    super
  end
end