module Commands
  module Ping
    extend Discordrb::Commands::CommandContainer

    command :ping,
            description: 'Check up on R2D2.',
            usage:       'ping' do |event|
      break if Settings.public_channel?(event.channel)

      event.send_message 'beep boop'
    end
  end
end
