require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

helpers do
  def calculate_total(cards)
    arr = cards.map { |e| e[1] }

    total = 0
    arr.each do |value|
      if value == 'A'
        total += 11
      elsif value.to_i == 0 # J, Q, K
        total += 10
      else
        total += value.to_i
      end
    end

    # correct for aces
    arr.select { |e| e == 'A' }.count.times do
      total -= 10 if total > 21
    end

    total
  end # end calculate_total method

   def image_string(card)
          suit = case card[0]
                      when 'H' then 'Hearts'
                      when 'D' then 'Diamonds'
                      when 'S' then  'Spades'
                      when 'C' then  'Clubs'
                    end

         value = case card[1]
                        when 'J' then 'jack'
                        when 'Q' then 'queen'
                        when 'K' then  'king'
                        when 'A' then  'ace'
                      else
                        card[1]
                      end

    "#{suit}_#{value}.jpg"
  end # end image string method
end # end helpers

get '/' do
  erb :set_name
end

post '/set_name' do
  session[:player_name] = params[:player_name]
  session[:initialize_game] = true
  redirect '/game'
end

get '/game' do

  if session[:initialize_game]
    suits = ['H', 'D', 'S', 'C']
    cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

    deck = suits.product(cards)
    deck.shuffle!

    session[:deck] = deck
    session[:player_cards] = []
    session[:dealer_cards] = []

    session[:player_cards] << session[:deck].pop
    session[:dealer_cards] << session[:deck].pop
    session[:player_cards] << session[:deck].pop
    session[:dealer_cards] << session[:deck].pop
  end


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
