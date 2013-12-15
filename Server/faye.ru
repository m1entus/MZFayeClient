require 'faye'
FAYE_TOKEN = "test"

class ServerAuth
  def incoming(message, callback)
    if message['channel'] !~ %r{^/meta/}
      if message['ext']['auth_token'] != FAYE_TOKEN
        message['error'] = 'Invalid authentication token'
      end
    end
    callback.call(message)
  end
end

Faye::WebSocket.load_adapter 'thin'

faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
# faye_server.add_extension(ServerAuth.new)
run faye_server
