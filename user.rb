require 'bcrypt'

class User
  
  include BCrypt

  def initialize name, password
    @name = name
    @password = Password.create(password, :cost => 1)
  end
  def name
    @name
  end
  def password
    @password
  end
end
