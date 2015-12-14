require 'optparse'
require './session_manager'
require './user'

class CLIRunner
  def self.run argv
    cmd_opts = parse argv
    instanciate_cmd_object cmd_opts
  end  

  def self.instanciate_cmd_object cmd
    name = "Carlos"
    password = "1234"
    User.create(name: name, password: password)
    if cmd.keys.include? :login
      args = eval(cmd[:login])
      puts SessionManager::authenticate(args[:name], args[:pass])
    else
      p "no args"
    end
  end

  def self.parse argv
    cmd = []
    values = {}
    OptionParser.new do |opts|
      opts.banner = "\n\t--login=\"['some@email.com','password']\"\n"
      opts.separator "Command line..."
      opts.on('--login array', 'Login into the system'){|o| cmd << '--login'; values[:login] = o }
    end.parse!(argv)
    values
  end
end

CLIRunner.run ARGV
