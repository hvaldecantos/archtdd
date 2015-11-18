require 'bcrypt'
require './password_confirmation_exception'

class User
  
  include BCrypt

  def initialize name, password, password_confirmation
    raise PasswordConfirmationException.new("Passwords do not match") if password != password_confirmation
    @name = name
    @password = Password.create(password, :cost => 1)
  end
  def name
    @name
  end
  def set_password password
    @password = Password.create(password, :cost => 1)
  end
  def password
    @password
  end
end
