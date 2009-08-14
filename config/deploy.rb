set :application, "echologic"
set :domain, "echologic.org"
set :user, "vu2005"

# For a Subversion repository
set :repository,  "http://echo-source.org/svn/echoLogic/trunk"

set :use_sudo, false                                  # HostingRails users don't have sudo access
set :deploy_to, "."                       # Where on the server your app will be deployed
set :deploy_via, :checkout                # For this tutorial, svn checkout will be the deployment method, but check out :remote_cache in the future
set :group_writable, false                # By default, Capistrano makes the release group-writable. You don't want this with HostingRails
# set :mongrel_port, "4444"                           # Mongrel port that was assigned to you
# set :mongrel_nodes, "4"                             # Number of Mongrel instances for those with multiple Mongrels

default_run_options[:pty] = true
# Cap won't work on windows without the above line, see
# http://groups.google.com/group/capistrano/browse_thread/thread/13b029f75b61c09d
# Its OK to leave it true for Linux/Mac

role :app, "vu2005.kappa.railshoster.de"
role :web, "vu2005.kappa.railshoster.de"
role :db,  "vu2005.kappa.railshoster.de", :primary => true
