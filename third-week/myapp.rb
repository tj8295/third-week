require 'sinatra'

# get '/' do
#   'hello world!'
# end

# get '/hello/:name' do
#   # matches "GET /hello/foo" and "Get /hello/bar"
#   # params[:name] is 'foo' or 'bar'
#   "Hello #{params[:name]}!"
# end

# get '/hello/:name' do |n|
#   # matches "GET /hello/foo" and "GET /hello/bar"
#   # params[:name] is 'foo' or 'bar'
#   # n stores params[:name]
#   "Hello #{n}!"
# end

# get '/say/*/to/*' do
#   #matches /say/hello/to/world
#   params[:splat]
# end

# get '/downoad/*.*' do |path, ext|
#   [path, ext] # => ["path/to/file", "xml"]
# end

# get %r{/hello/([\w]+)} do |c|
#   "Hello, #{c}!"
# end

get '/posts.?:format?' do
  "output"
end
