require 'mongrel_cluster/recipes'

set :application, "echologic"
set :repository,  "http://echo-source.org/svn/echoLogic/trunk"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
#set :deploy_to, "htdocs/#{application}"
set :deploy_to, '.'

# 
set :use_sudo, false

# user for the ssh connection
set :user, "echologic"

# locate the config file for mongrel clustering
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "85.214.99.166"
role :web, "85.214.99.166"
role :db,  "85.214.99.166", :primary => true