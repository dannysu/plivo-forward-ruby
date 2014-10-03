require 'rubygems'
require 'sinatra'
require 'json'
require 'yaml'
require 'plivo'
include Plivo

config = YAML::load(IO.read('.env'))

p = RestAPI.new(config['PLIVO_AUTH_ID'], config['PLIVO_AUTH_TOKEN'])

get '/ping' do
  "pong"
end

get '/forward_call' do
  r = Response.new()
  d = r.addDial({'callerId' => params['From']})
  d.addNumber(params['Numbers'])

  r.to_xml()
end

get '/forward_sms' do
  content = params['From'] + ': ' + params['Text']
  p.send_message({'src' => config['SMS_FROM'], 'dst' => params['Numbers'], 'type' => 'sms', 'text' => content})

  r = Response.new()
  r.to_xml()
end
