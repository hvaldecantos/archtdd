require 'optparse'
require './session_manager'
require './user'

class CLIRunner
  def self.run argv
    cmd_opts = parse argv
    instanciate_cmd_object cmd_opts
  end  

  def self.instanciate_cmd_object cmd
    if cmd.keys.include? :login
      args = eval(cmd[:login])
      puts SessionManager::authenticate(args[:name], args[:pass])
    elsif cmd.keys.include? :new_user
      args = eval(cmd[:new_user])
      User.create(name: args[:name], password: args[:pass])
    else
      p "no args"
    end
  end

  def self.parse argv
    cmd = []
    values = {}
    OptionParser.new do |opts|
      opts.banner = "\n\t--login \"{name: 'username', pass: '1234'}\"" +
                    "\n\t--new-user \"{name: 'username', pass: '1234'}\"\n"
      opts.separator "Command line ."
      opts.on('--login <hash>', 'Login into the system'){|o| cmd << '--login'; values[:login] = o }
      opts.on('--new-user <hash>', 'Add a new user in the system'){|o| cmd << '--new-user'; values[:new_user] = o }
    end.parse!(argv)
    values
  end
end

CLIRunner.run ARGV
