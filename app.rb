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

		begin
		db_password = db.execute('SELECT password FROM Users where username=?',[username])[0][0]
		rescue
			p 'no such username exist'
			redirect ('/')
		else
		p db_password
		p password
		end
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

	post '/chat' do
		new_subject = 200
		time = 0
		while time < new_subject
			db.execute('SELECT message FROM Content')
		end
	end

	post '/register' do
		db = SQLite3::Database.new("database/chatsystem.db")
		username = params[:username]
		password = params[:password]
#		password_digest == BCrypt::Password.new(passwor)
		email = params[:email]
		db.execute("INSERT INTO Users(username,password,email) VALUES(?,?,?)",[username,password,email])
		redirect('/')
	end

end
