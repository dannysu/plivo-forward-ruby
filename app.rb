require 'sinatra'
set :protection, except: :json_csrf

require './api'
