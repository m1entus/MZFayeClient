require 'faye'
require 'eventmachine'

EM.run {
  client = Faye::Client.new('http://localhost:9292/faye')

  client.subscribe('/browser') do |message|
    puts message.inspect
  	client.publish('/server', {'text' => 'Hello from server'})
  end

}
