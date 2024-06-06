set :rails_env, 'production'
server 'vps57514.dreamhostps.com', user: 'biohack_vps', roles: [:web]
set :deploy_to, "/home/biohack_vps/forum_archive"
set :branch, 'main'