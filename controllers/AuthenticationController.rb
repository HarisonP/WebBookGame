class MyGameBase < Sinatra::Base
  get '/register' do
    haml :register, {locals:{show_error_message:"fua"}}
  end

  post '/register' do
    # no escaping:
    escaped_params = {username:params[:username], 
                  password:params[:password],
                  repeated_password:params[:repeated_password],
                  email:params[:email],
                  }
    Models.register escaped_params
    haml :login
  end


  get '/login' do
    haml :login
  end

  get '/logout' do
  end

  # helpers AuthenticationHelpers, WebsiteHelpers
  # helpers DataBaseHelpers::UserHelpers
  # helpers ViewHelpers
end