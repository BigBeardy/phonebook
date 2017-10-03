def checklogin(user,pass)

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db= PG::Connection.new(db_params)

	checkuser = db.exec("SELECT * FROM pblogin WHERE username = '#{user}'")

	if checkuser.num_tuples.zero? == false
		cp = checkuser.values.flatten
        checkpass = BCrypt::Password.new(cp[1])
        if checkpass == pass
        	message = "successful login"
        else
			message = "failed login"
		end	
    else
       message = "failed login"
    end
    message
end  


def putinloginpb(user,pass)

db_params = {
	host: ENV['host'],
	port: ENV['port'],
	dbname: ENV['dbname'],
	user: ENV['user'],
	password: ENV['password']
}

db = PG::Connection.new(db_params)	

 
 passbc = BCrypt::Password.create "#{pass}"
     
answer = ""
check = db.exec("SELECT * FROM pblogin WHERE username = '#{user}'")

    if check.num_tuples.zero? == false
        answer = "Your Number is already being used"
    else
        answer = "you joined this phone book"
        db.exec("insert into pblogin(username,answer)VALUES('#{user}','#{passbc}')")
    end
    answer

end
