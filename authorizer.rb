class Authorizer
  def self.is_authorized? user, required_role
    user.has_role?(required_role)
  end
end
