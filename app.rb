require 'sinatra/base'
require './lib/convert.rb'

class App < Sinatra::Base
  get '/' do
    erb :index
  end

  put '/' do
    convert_to_plain(request.body.read)

    # puts "uploaded #{env['HTTP_X_FILENAME']} - #{request.body.read.size} bytes"
    # redirect '/download_latest'
  end

  get '/download_latest' do
    send_file 'tmp/result.txt', :disposition => 'attachment'  
  end
end
