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

   def card_image(card)
          suit = case card[0]
                      when 'H' then 'Hearts'
                      when 'D' then 'Diamonds'
                      when 'S' then  'Spades'
                      when 'C' then  'Clubs'
                    end

        value = card[1]
        if %w(J Q K A).include?(value)
          value = case card[1]
                        when 'J' then 'jack'
                        when 'Q' then 'queen'
                        when 'K' then  'king'
                        when 'A' then  'ace'
                      end
        end

    "<img src='/images/cards/#{suit}_#{value}.jpg' class='card_image'/>"

  end # end image string method

  def dealer_blackjack

  end
end # end helpers

before do
  @show_hit_or_stay_buttons = true
  @blackjack = false
  @bust = false
  @play_again = false
  @dealer_turn = false
end

get '/' do
  if session[:player_name]
    redirect '/game'
  else
    redirect '/new_player'
  end
end

get '/new_player' do
  erb :new_player
end

post '/new_player' do
  if params[:player_name].strip.empty?
    @error = "Please input name"
    halt erb(:new_player)
  end

  session[:player_name] = params[:player_name]
  redirect '/game'
end

get '/game' do

    suits = ['H', 'D', 'S', 'C']
    cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    session[:deck] = suits.product(cards).shuffle!

    session[:player_cards] = []
    session[:dealer_cards] = []

    session[:player_cards] << session[:deck].pop
    session[:dealer_cards] << session[:deck].pop
    session[:player_cards] << session[:deck].pop
    session[:dealer_cards] << session[:deck].pop


  erb :game
end

post '/game/player/hit' do
  session[:player_cards] << session[:deck].pop

  player_total = calculate_total(session[:player_cards])
  if player_total == 21
    @success = "Blackjack #{session[:player_name]} wins!"
    @show_hit_or_stay_buttons = false
    @play_again = true
  end
  if player_total > 21
    @error = "Sorry #{session[:player_name]} busted."
    @show_hit_or_stay_buttons = false
    @play_again = true
  end
  erb :game
end

post '/game/player/stay' do
  # Not sure where this line comes from, the @success will not be available in redirect.
  @success = "#{session[:player_name]} has chosen to stay"
  redirect '/game/dealer'
end


get '/game/dealer' do
  @show_hit_or_stay_buttons = false

  # decision tree
  dealer_total = calculate_total(session[:dealer_cards])
  if dealer_total == 21
    @error = "Sorry Dealer hit blackjack dealer wins!"
  elsif dealer_total > 21
    @success = "Congrautlations, dealer busts, you win!"
  elsif dealer_total >= 17
    #dealer stays
    redirect 'game/compare/'
  else
    #dealer hits
    @show_dealer_hit_button = true
  end
  erb :game
end

post '/game/dealer/hit' do
    session[:dealer_cards] << session[:deck].pop
    redirect 'game/dealer'
end

get '/game/compare/' do
     @show_dealer_hit_button = false
     @show_hit_or_stay_buttons = false
     @play_again = true

    player_total = calculate_total(session[:player_cards])
    dealer_total = calculate_total(session[:dealer_cards])

    if dealer_total > player_total
      @error = "Sorry, dealer wins."
    elsif player_total > dealer_total
      @success = "Congrautlations, you win."
    else
      @success = "Push. There was a tie"
     end
     erb :game
end # route end

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
