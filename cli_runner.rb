require 'optparse'
require './session_manager'
require './authorizer'
require './user'

class CLIRunner
  def self.run argv
    cmd_opts, symb = parse(argv)
    instanciate_cmd_object cmd_opts, symb
  end  

  def self.instanciate_cmd_object cmd, symb
    args = eval(cmd[symb])

    if cmd.keys.include? :login
      puts "logging in     ----------------------"
      p SessionManager::login(args[:name], args[:password])
    elsif cmd.keys.include? :new_user
      puts "creating users ----------------------"
      p User.create(args).save!
    elsif cmd.keys.include? :list_users
      puts "listing users  ----------------------"
      Authorizer.add_action({action: :list_users, role: "admin"})
      if SessionManager::is_valid_token?(args[:token])
        puts "> authenticated through token"
        if Authorizer::is_authorized?(User.find_by_name(args[:name]), :list_users)
          puts "> authorized"
          User.all.each{|u| puts u.name}
        else
          puts "> Unauthorized"
        end
      else
        puts "> Invalid token"
      end
    else
      p "> no args"
    end
  end

  def self.parse argv
    cmd = ""
    values = {}
    OptionParser.new do |opts|
      opts.banner = "\nOptions for <hash> according command:" +
                    "\n\t--login \"{name: 'username', password: '1234'}\"" +
                    "\n\t--list-users \"{name: 'username', token: 'token'}\"" +
                    "\n\t--new-user \"{name: 'username', password: '1234', role: 'admin'}\"\n"
      opts.separator "Command line:"
      opts.on('--login <hash>', 'Login into the system'){|o| cmd = :login; values[:login] = o }
      opts.on('--new-user <hash>', 'Add a new user in the system'){|o| cmd = :new_user; values[:new_user] = o }
      opts.on('--list-users <hash>', 'Add a new user in the system'){|o| cmd = :list_users; values[:list_users] = o }
    end.parse!(argv)
    [values, cmd]
  end
end

CLIRunner.run ARGV
