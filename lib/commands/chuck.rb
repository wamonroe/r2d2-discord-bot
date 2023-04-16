require 'faraday'
require 'faraday_middleware'

class GetChuckFact
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def random
    response.body['value'] || default_message
  rescue StandardError
    default_message
  end

  def self.random(name)
    new(name).random
  end

private

  def categories
    'animal,career,celebrity,fashion,food,history,money,movie,music,science,sport,travel'
  end

  def connection
    Faraday.new do |faraday|
      faraday.response :json
    end
  end

  def default_message
    "I'm sorry, but I can't do that right now #{name}"
  end

  def response
    connection.get("https://api.chucknorris.io/jokes/random?category=#{categories}") do |request|
      request.headers['Accept'] = 'application/json'
    end
  end
end

module Commands
  module Chuck
    extend Discordrb::Commands::CommandContainer

    command :chuck,
            description: 'Sends a random fact Chuck Norris fact.',
            usage:       'chuck' do |event|
      break if Settings.public_channel?(event.channel)

      event.send_message GetChuckFact.random(event.user.mention)
    end
  end
end
