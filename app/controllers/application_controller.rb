class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  get '/registrations/signup' do

    erb :'/registrations/signup'
  end

#saves our user's info
  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id #here we are setting the new user id to a new instance @user_id

    redirect '/users/home' #redirects home
    #puts params
  end

  get '/sessions/login' do

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id #this finds the correct user by db and logs them in
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  get '/sessions/logout' do
    session.clear #clears the data upon logout
    redirect '/'
  end

  get '/users/home' do

    @user = User.find(session[:user_id]) #finds the current user based on the id stored in the sessions hash and sets it to an instance variable
    erb :'/users/home'
  end
end
