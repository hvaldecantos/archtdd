require 'bcrypt'
require './password_confirmation_exception'
require 'active_record'
require './db_schema'

class User < ActiveRecord::Base
  attr_writer :password_confirmation

  include BCrypt

  def initialize opt = {}
    super opt
    set_password opt
  end
  def set_password opt = {}
    self.password = Password.create opt[:password], :cost => 1
  end
  def has_role? role
    self.role == role
  end
end
