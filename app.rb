require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'lib/hangman.rb'


configure do
  enable :sessions
  set :session_secret, 'secret'
end



#hangman = Game.new

get '/' do

  session[:game] = Game.new if session[:game].nil?

  if params["letter"] != nil
    session[:game].check(params["letter"])
  end

  if params[:restart] == "true"
		session[:game] = Game.new
	end


  erb :index, :locals => {:lives => session[:game].lives_left,
                          :chosen_letters => session[:game].chosen_letters,
                          :guessing => session[:game].display_word,
                          :message => session[:game].status,
                          :input_status => session[:game].input_status
                         }

=begin
  if params["text"] != nil && params["shift"] != nil
    encrypted = caesar_cipher(params["text"].to_s, params["shift"].to_i)
  end



  erb :index, :locals => {:encrypted => encrypted }

=end

end
