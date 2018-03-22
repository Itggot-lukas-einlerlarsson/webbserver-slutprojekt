class App < Sinatra::Base

	get '/' do
		"Hello, Grillkorv!"
		slim(:index)
	end

	get '/register' do
	 slim(:register)
 end

end
