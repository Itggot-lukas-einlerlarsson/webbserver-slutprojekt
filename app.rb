class App < Sinatra::Base

	connections = []

	get '/' do
			"Hello, Grillkorv!"
			slim(:index)
	end

	get '/register' do
		 slim(:register)
	end


	def set_error(error_message)
		session[:error] = error_message
	end


	post '/login' do
		db = SQLite3::Database.new("database/chatsystem.db")
		username = params["username"]
		password = params["password"]
		db_password = db.execute('SELECT password FROM Users where username=?',[username])[0][0]
		p db_password
		p password
		if password == db_password
			session[:user_id] = username
			p 'succefully logged in'
			redirect('/chat')
		else
			p 'invalid credentials'
			redirect('/')
		end
	end

	get '/chat' do
		user_id = session[:user_id]
		slim(:chat)
	end

	post '/register' do
		db = SQLite3::Database.new("database/chatsystem.db")
		username = params[:username]
		password = params[:password]
		email = params[:email]
		db.execute("INSERT INTO Users(username,password,email) VALUES(?,?,?)",[username,password,email])
		redirect('/')
	end

end
