require 'xmlrpc/server'
require 'nokogiri'
require 'rubygems'
require 'libxml'

module SCrAP

  class Version
    def stuff
      stuff = "<?xml version=\"1.0\"?><version>SCrAP.Bot Version 0.1</version>"
      return stuff
    end
    def parse(xml)
      #return xml
      doc = Nokogiri::XML.parse(xml)
      ver = doc.xpath("//version").collect(&:text)
      return ver
    end
  end
  
  class Oval
    def read(file)
      doc = Nokogiri::XML.parse(File.open(file, "r"))
      return doc.xpath("//version").collect(&:text)
    end
    def validate(xml)
      File.open('./oval/tmp.xml', 'w') do |f|
        f.write(xml)
      end
      val = `/usr/bin/PParse -n -s -f -v=always ./oval/tmp.xml`
      rgx = Regexp.new("Error")
      val =~ rgx and return "File was good"
      return "File was bad"
    end
  end
end