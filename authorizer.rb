class Authorizer
  @@actions = []
  def self.actions
    @@actions
  end
  def self.actions= value
    @@actions = value
  end
  def self.is_authorized? user, action
    @@actions.select {|a| a[:action] == action && user.has_role?(a[:role])}.size > 0
  end
  def self.add_action action
  	@@actions << action
  end
end
