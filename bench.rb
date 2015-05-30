#!/usr/bin/env ruby
require 'rubygems'
require 'eventmachine'
require 'em-http'
require 'net/http'
require 'uri'

count = ARGV.empty? ? 10 : ARGV.shift.to_i

successes = 0
EM::run do

  count.times do
    http = EM::HttpRequest.new('http://localhost:5000/chat').get
    http.callback do |res|
      puts "GET success"
      puts res.response_header.status
      puts res.response
      successes += 1
      EM::stop if successes == count
    end
    http.errback do |err|
      puts "GET error"
      puts err.response_header.status
      puts err.error
      puts err.response
    end
  end
  
end
