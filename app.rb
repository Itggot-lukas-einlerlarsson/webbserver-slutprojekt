class App < Sinatra::Base

	get '/' do
			"Hello, Grillkorv!"
			slim(:index)
	end

	get '/register' do
		 slim(:register)
	end

	post '/login' do
		db = SQLite3::Database.new("database/chatsystem.db")
		username = params[:username]
		password = params[:password]
		if password == db.execute('SELECT password FROM Users where username=?',[username])
			session[:user_id] = user_id
		end
	end

	post '/register' do
		db = SQLite3::Database.new("database/chatsystem.db")
		username = params[:username]
		password = params[:password]
		email = params[:email]
		db.execute("INSERT INTO Users(username,password,email) VALUES(?,?,?)",[username,password,email])
	#	puts "something went wrong, try again"
	#	redirect('/register')
		redirect('/')
	end

end
