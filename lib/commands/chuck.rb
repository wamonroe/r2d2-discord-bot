module Commands
  module Chuck
    extend Discordrb::Commands::CommandContainer

    command :chuck,
            description: 'Sends a random fact about Chuck Norris.',
            usage:       'chuck' do |event|
      break if Settings.public_channel?(event.channel)

      event.send_message Faker::ChuckNorris.fact
    end
  end
end
