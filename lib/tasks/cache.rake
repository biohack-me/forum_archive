namespace :cache do
  desc 'Clears the Rails cache'
  task :clear => :environment do
    Rails.cache.clear
  end
end