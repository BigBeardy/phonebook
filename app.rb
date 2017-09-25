require 'sinatra'
require 'pg'
enable :sessions
load './local_env.rb' if File.exist?('./local_env.rb') 

db_params = {
    host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['db_name'],
    user: ENV['user'],
    password: ENV['password'], 
   } 
 


     db= PG::Connection.new(db_params)
get '/' do 
  phonebooktable = db.exec("SELECT * FROM public.phonebook")
  erb :phonebook, locals:{retrievedbook:phonebooktable}
	
end 
 
# post '/phonebook'
#     local 
#     redirect '/finalpage' 
  



post '/phonebook' do
   
  pdata = params[:value]
"#{pdata[0]},#{pdata[1]}, #{pdata[2]},#{pdata[3]},#{pdata[4]}"

 db.exec("insert into public.phonebook(first,last,num,zip,street)VALUES('#{pdata[0]}','#{pdata[1]}', '#{pdata[2]}','#{pdata[3]}','#{pdata[4]}')" )
 redirect'/'
end 

 post '/update' do 
     id = params[:id]
        # erb :phonebook, locals:{retrievedbook:phonebooktable}


#  data = []
  
#     db.exec( "SELECT * FROM phonebook" ) do |result|
#           result.each do |row|
#               data << row.values
#             end
#             data
#           end
      
      
 end 
# post '/finalpage'
#       erb :phonebook,
  



