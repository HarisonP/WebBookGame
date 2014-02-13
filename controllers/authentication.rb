class MyGameBase < Sinatra::Base
  get '/register' do
    haml :register
  end

  post '/register' do
    # no escaping:
    escaped_params = {username:params[:username], 
                  password:params[:password],
                  repeated_password:params[:repeated_password],
                  email:params[:email],
                  }
    if Models::Authentication.register escaped_params
      haml :login
    else
      haml :register, {locals:{error_message:"Incorect Data"}}
    end

  end


  get '/login' do
    haml :login
  end
  post '/login' do
    if Models::Authentication.login username: params[:username], password: params[:password]
      "Succsess" 
    else
      haml :login, {locals:{error_message:"Wrong password or username."}}
    end
  end
  
  get '/logout' do
  end

  # helpers AuthenticationHelpers, WebsiteHelpers
  # helpers DataBaseHelpers::UserHelpers
  # helpers ViewHelpers
end