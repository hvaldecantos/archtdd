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
    raise PasswordConfirmationException.new("Passwords do not match") if opt[:password] != opt[:password_confirmation]
    self.password = Password.create opt[:password], :cost => 1
  end
end
