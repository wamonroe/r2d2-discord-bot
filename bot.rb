require 'bundler/setup'
require_relative 'settings'

Dir[File.join(__dir__, 'lib/**/*.rb')].each do |file|
  require file
end

bot = Discordrb::Commands::CommandBot.new(
  token:     ENV['R2D2_TOKEN'],
  client_id: ENV['R2D2_CLIENT_ID'],
  prefix:    '!'
)

bot.include! Commands::Chuck
bot.include! Commands::DadJoke
bot.include! Commands::Fate
bot.include! Commands::MostInteresting
bot.include! Commands::Ping
bot.include! JoinMessage

bot.run
