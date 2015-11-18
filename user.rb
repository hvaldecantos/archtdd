require 'bcrypt'
require './password_confirmation_exception'

class User
  
  include BCrypt

  def initialize opt = {}
    set_password opt
    @name = opt[:name]
  end
  def name
    @name
  end
  def set_password opt = {}
    raise PasswordConfirmationException.new("Passwords do not match") if opt[:password] != opt[:password_confirmation]
    @password = Password.create opt[:password], :cost => 1
  end
  def password
    @password
  end
end
