require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

helpers do
  def calculate_total(cards)
    55
  end
end

get '/' do
  erb :set_name
end


post '/set_name' do
  session[:player_name] = params[:player_name]
  redirect '/game'
end

get '/game' do
  session[:deck] = [['2', 'H'], ['3', 'D']]
  session[:player_cards] = []
  session[:player_cards] << session[:deck].pop
  erb :game
end

# get '/test' do
#   @my_var = "Tom"
#   erb :test
# end

  # redirect '/'
    # "From the testing action." + params[:some].to_s



get '/form' do
  erb :form
end

post '/myaction' do
  puts params['username']
end

get '/inline' do
  "Hi, directly from the action!"
end

get '/template' do
  erb :mytemplate, layout: 'layout'
end

get '/nested_template' do
  erb :"/users/profile"
end

get '/nothere' do
  redirect '/inline'
end

# get '/' do
#   'Hello Tom'
# end

get '/home/' do
  "Welcome home! Its been a while. Ok"
end

# get '/' do
#   erb :first_layout
# end

# get '/directory1/' do
#   erb :second_layout
# end
