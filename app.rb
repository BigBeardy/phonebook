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

 db.exec("insert into public.phonebook(first,last,num,zip,street)VALUES('#{pdata[0]}','#{pdata[1]}','#{pdata[2]}','#{pdata[3]}','#{pdata[4]}')")
 redirect'/'
end 

get '/update' do 
  pdata = params[:value]
  db_params = {
    host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['db_name'],
    user: ENV['user'],
    password: ENV['password'], 
   } 
   db= PG::Connection.new(db_params)
   updating = db.exec("SELECT * FROM public.phonebook WHERE id ='#{id}")
   erb :phonebook, locals:{updating:updating, pdata:pdata}


end

post '/update' do 
    pdata = params[:pdata]
    updating = params[:updating]
    id = params[:id]
    choice = params[:choice]
    first = params[:first]
    last = params[:last]
    num = params[:num]
    street = params[:street]
    zip = params[:zip]
p id
     db_params = {
    host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['db_name'],
    user: ENV['user'],
    password: ENV['password'], 
   } 
  db = PG::Connection.new(db_params)
 
    if choice == 'update' 
      db.exec("UPDATE phonebook SET zip='#{zip}', num='#{num}', last='#{last}', first='#{first}', street='#{street}'
  WHERE id = '#{id.to_i}'")
       # db.exec("UPDATE public.phonebook SET (first=value[0],last='value[1]',street='value[2]',num='value[3]',zip='value[4]' WHERE id = '#{id}')")
       # db.exec("UPDATE public.phonebook SET first='#{pdata}',last='#{pdata}',street='#{pdata}',num='#{pdata}',zip='#{pdata}' WHERE id = '#{id}'")
  redirect '/'

    elsif choice == 'delete' 
   db.exec("DELETE FROM public.phonebook WHERE id ='#{id}'")
  redirect '/'  
    end
end
 
  



