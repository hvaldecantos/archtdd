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

  def self.logout token
    s = Session.find_by_token(token)
    s.destroy if s != nil
  end

  def self.is_valid_token? token
    s = Session.find_by_token(token)
    return s != nil && !s.is_expired? && s.token == token
  end
end
