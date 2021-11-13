require 'faker'

class MostInterestingQuote
  attr_reader :gender

  def initialize(gender = nil)
    @gender = gender || 'm'
  end

  def self.random(gender = nil)
    new(gender).random
  end

  def random
    Faker::Quote.most_interesting_man_in_the_world.tap do |quote|
      fix_annoying_quotes!(quote)
      apply_female_pronouns!(quote) if female?
    end
  end

private

  def female?
    gender == 'f'
  end

  def fix_annoying_quotes!(quote)
    quote.sub!('5 de Mayo', 'Cinco de Mayo')
    quote.sub!('that he only speaks', 'that only he speaks')
  end

  def apply_female_pronouns!(quote)
    quote.gsub!(/\b(HIS|HIM)\b/, 'HER')
    quote.gsub!(/\b(His|Him)\b/, 'Her')
    quote.gsub!(/\b(his|him)\b/, 'her')
    quote.gsub!(/\bHE\b/, 'SHE')
    quote.gsub!(/\bHe\b/, 'She')
    quote.gsub!(/\bhe\b/, 'she')
    quote.gsub!(/\bbeard\b/, 'leg hair')
    quote.gsub!(/\bcologne\b/, 'perfume')
    quote.gsub!(/\bSon\b/, 'Daughter')
  end
end

module Commands
  module MostInteresting
    extend Discordrb::Commands::CommandContainer

    Settings.interesting_people.each do |name, gender|
      command name,
              description: "Sends a random fact about #{name.capitalize}.",
              usage:       name do |event|
        break if Settings.public_channel?(event.channel)

        event.send_message MostInterestingQuote.random(gender)
      end
    end
  end
end
