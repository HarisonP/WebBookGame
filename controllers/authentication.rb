class MyGameBase < Sinatra::Base
  get '/register' do
    haml :register
  end

  post '/register' do
    # no escaping:
    escaped_params = {db:settings.db, username:params[:username], 
                  password:params[:password],
                  repeated_password:params[:repeated_password],
                  email:params[:email],
                  }
    if Models::Authentication.register escaped_params
      redirect '/heroes-navigation'
    else
      haml :register, {locals:{error_message:"Incorect Data"}}
    end

  end


  get '/login' do
    haml :login
  end

  post '/login' do
    id = Models::Authentication.login db: settings.db, username: params[:username], password: params[:password]
    if id 
      session['is_logged'] = true
      session['user_id'] = id
      redirect "/heroes-navigation"
    else
      haml :login, {locals:{error_message:"Wrong password or username."}}
    end
  end
  
  get '/logout' do
  end

end