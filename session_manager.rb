require './user'
require './session'

class SessionManager

  def self.authenticate user, pass
    user = User.find_by_name(user)
    return false if user == nil
    user.password == BCrypt::Engine.hash_secret(pass, user.password)
  end

  def self.login user, pass
    return nil unless self.authenticate(user, pass)
    user = User.find_by_name(user)
    Session.create user: user
  end
end
