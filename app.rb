require 'sinatra'
require 'pg'
enable :sessions
load './local_env.rb' if File.exist?('./local_env.rb') 

get '/' do 
	erb :phonebook 
	
end 
 

post '/phonebook' do 
    session[:pdata] = params[:value]
    
  p "#{session[:pdata]}"

     # erb :phonebook, :locals => { 
     # first: session[:first],
     #  last: session[:last],
     #  zip: session[:zip],
     #  street: session[:street]} 
    end

