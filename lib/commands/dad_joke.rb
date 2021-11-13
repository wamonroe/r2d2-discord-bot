require 'faraday'
require 'faraday_middleware'

class GetDadJoke
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def random
    response.body['joke'] || default_message
  rescue StandardError
    default_message
  end

  def self.random(name)
    new(name).random
  end

private

  def connection
    Faraday.new do |faraday|
      faraday.response :json
    end
  end

  def default_message
    "I'm sorry, but I can't do that right now #{name}"
  end

  def response
    connection.get('https://icanhazdadjoke.com') do |request|
      request.headers['Accept'] = 'application/json'
    end
  end
end

module Commands
  module DadJoke
    extend Discordrb::Commands::CommandContainer

    command :dadjoke,
            description: 'Sends a random fact dad joke.',
            usage:       'dadjoke' do |event|
      break if Settings.public_channel?(event.channel)

      event.send_message GetDadJoke.random(event.user.mention)
    end
  end
end
