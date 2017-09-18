require 'sinatra'
require 'pg'
enable :sessions
load './local_env.rb' if File.exist?('./local_env.rb') 

get '/' do 
	erb :phonebook 
	
end 
db_params = {
   	host: ENV['host'],
   	port: ENV['port'],
   	dbname: ENV['db_name'],
   	user: ENV['user'],
   	password: ENV['password'],
   } 
 


   db= PG::Connection.new(db_params)
post '/phonebook' do 
  pdata = params[:value]
# "#{pdata[0]},#{pdata[1]}, #{pdata[2]},#{pdata[3]},#{pdata[4]}"
 


   db.exec("insert into public.phonebook(first,last,num,zip,street)VALUES('#{pdata[0]}','#{pdata[1]}', '#{pdata[2]}','#{pdata[3]}','#{pdata[4]}')" )
 end 




