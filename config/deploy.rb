set :application, 'forum_archive'
set :repo_url,  "https://github.com/biohack-me/forum_archive"
set :linked_files, %w{config/master.key config/credentials.yml.enc config/database.yml}
set :linked_dirs, %w{app/assets/images/userpics app/assets/images/uploads tmp/pids tmp/sockets log}
set :keep_releases, 6
set :tmp_dir, "/home/biohack_vps/tmp"
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-3.3.4'
set :ssh_options, {
  forward_agent: true
}
set :use_sudo, false
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_systemctl_bin, '/usr/bin/systemctl'
set :puma_service_unit_name, "puma"
set :puma_systemctl_user, :user