require 'rubygems'
require 'sinatra'

set :sessions, true

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

get '/' do
  erb :first_layout
end

get '/directory1/' do
  erb :second_layout
end
