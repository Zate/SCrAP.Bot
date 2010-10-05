#! /usr/bin/env ruby


require './lib/init'

include SCrAP

s = XMLRPC::Server.new(8080, "0.0.0.0", 1)

s.add_handler("michael.add") do |a,b|
  a + b
end

s.add_handler("michael.div") do |a,b|
  if b == 0
    raise XMLRPC::FaultException.new(1, "division by zero")
  else
    a / b
  end
end

#ver = Nokogiri::XML::Builder.new do |xml|
#  xml.scapbot {
#    xml.version "SCrAP.Bot Version 0.1"
#  }
#end

ver="<?xml version=\"1.0\"?><version>SCrAP.Bot Version 0.1</version>"

s.add_handler("version") do |a|
  #if a == "true"
  ver
  
    
  #end
  
end

s.add_handler("version2") do |a|
  x = Version.new
  x.stuff
  
end

s.add_handler("parser") do |xml|
  x = Version.new
  x.parse(xml)
end

s.add_handler("validate") do |xml|
  x = Oval.new
  x.validate(xml)
end


s.set_default_handler do |name, *args|
  raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
                                   " or wrong number of parameters!")
end


#test = Oval.new
#puts(test.validate('microsoft.windows.7.xml'))

s.serve

=begin
= XMLRPC::Server
== Synopsis
    require "xmlrpc/server"

    s = XMLRPC::Server.new(8080)

    s.add_handler("michael.add") do |a,b|
      a + b
    end

    s.add_handler("michael.div") do |a,b|
      if b == 0
        raise XMLRPC::FaultException.new(1, "division by zero")
      else
        a / b
      end
    end

    s.set_default_handler do |name, *args|
      raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
                                       " or wrong number of parameters!")
    end

    s.serve

== Description
Implements a standalone XML-RPC server. The method (({serve}))) is left if a SIGHUP is sent to the
program.

== Superclass
((<XMLRPC::WEBrickServlet>))

== Class Methods
--- XMLRPC::Server.new( port=8080, host="127.0.0.1", maxConnections=4, stdlog=$stdout, audit=true, debug=true, *a )
    Creates a new (({XMLRPC::Server})) instance, which is a XML-RPC server listening on
    port ((|port|)) and accepts requests for the host ((|host|)), which is by default only the localhost.
    The server is not started, to start it you have to call ((<serve|XMLRPC::Server#serve>)).

    Parameters ((|audit|)) and ((|debug|)) are obsolete!

    All additionally given parameters in ((|*a|)) are by-passed to ((<XMLRPC::BasicServer.new>)).

== Instance Methods
--- XMLRPC::Server#serve
    Call this after you have added all you handlers to the server.
    This method starts the server to listen for XML-RPC requests and answer them.

--- XMLRPC::Server#shutdown
    Stops and shuts the server down.

=end
