require 'sinatra'
require 'json'
require 'memory_record'

enable :sessions

get '/' do
  erb :index
end


get '/memory' do

  memory = if `ps -x | grep firefox` =~ /(\d+)/
    firefox_pid = $1
    memory = `ps -o rss= -p #{firefox_pid}`.strip.to_i
  end || 0

  memory_record = session[:memory_record] ||= MemoryRecord.new(memory)
  memory_record.memory = memory


  content_type :json
  memory_record.to_json
end


