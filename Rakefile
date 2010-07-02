def deploy_to_heroku(app_name, remote_name, config_vars=nil)
  exec_heroku app_name, "config:clear"
  if config_vars
    exec_heroku app_name, "config:add " + config_vars.map {|key,val| "#{key}=#{val}"}.join(' ')
  end
  system "git push #{remote_name} master --force"
end

def exec_heroku(app_name, command)
  system "heroku #{command} --app #{app_name}"
end

namespace :deploy do
  desc "deploy all pages"
  task :all => [:bjuenger, :blindgaenger]do
  end

  desc "deploy bjuenger.de"
  task :bjuenger do
    deploy_to_heroku 'bjuenger-homepage', 'heroku-bjuenger', {'PROFILE' => 'bjuenger'}
  end

  desc "deploy blindgaenger.net"
  task :blindgaenger do
    deploy_to_heroku 'blindgaenger-homepage', 'heroku-blindgaenger', {'PROFILE' => 'blindgaenger'}
  end
end

