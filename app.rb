require "Sinatra"
  set :sessions => true

  get '/' do
  slim(:index)
  end

	 get '/register' do
		 slim(:register)
	 end

   post 'login' do
   session[:user_id] = User.authenticate(params).id
   end

	 post '/register' do
		 begin
				db = SQLite3::Database.new("DTABASAHÄR")
				username = params[:username]
				password = params[:password]
				email = params[:email]
				password_digest = BCrypt::Password.create(password)
				db.execute("INSERT INTO Users(username,password_digest,email) VALUES(?,?,?)",[username,password,email])
			rescue
				puts "something went wog, try again"
				redirect('/register')
			else
			redirect('/')
		end
	 end
