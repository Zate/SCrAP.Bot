#! /usr/bin/env ruby

 require "xmlrpc/client"

    server = XMLRPC::Client.new("192.168.1.127", "/", 8080)
    begin
	xml = '' 
	f = File.open("./oval/microsoft.windows.7.xml", "r")
	f.each_line do |l|
		xml << l
	end	

      param = server.call("version2", 1)
      puts "#{param}"
	parse = server.call("validate", xml)
	puts "#{parse}"
    rescue XMLRPC::FaultException => e
      puts "Error:"
      puts e.faultCode
      puts e.faultString
    end


