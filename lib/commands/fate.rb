class FateDice
  attr_reader :skill

  OUTPUT_TEMPLATE = '%<icon>s %<value>+3i %<description>14s'.freeze

  DICE_VALUE_FACE = {
    -1 => '[-]',
    0  => '[ ]',
    1  => '[+]'
  }.freeze

  SKILL_LEVEL = {
    -2 => 'Terrible',
    -1 => 'Poor',
    0  => 'Mediocre',
    1  => 'Average',
    2  => 'Fair',
    3  => 'Good',
    4  => 'Great',
    5  => 'Superb',
    6  => 'Fantastic',
    7  => 'Epic',
    8  => 'Legendary'
  }.freeze

  def initialize(skill = nil)
    @skill = skill.nil? ? skill : skill.to_i
  end

  def roll
    dice = random_dice
    [].tap do |lines|
      lines << display_roll(dice)
      lines << display_skill unless skill.nil?
      lines << '=' * 21
      lines << display_result(dice)
    end.join("\n")
  end

  def self.roll(skill = nil)
    new(skill).roll
  end

private

  def dice_faces(dice)
    dice.map { |value| DICE_VALUE_FACE[value] }.join
  end

  def display_roll(dice)
    output icon: '🎲', description: dice_faces(dice), value: dice.sum
  end

  def display_skill
    output icon: '💪', description: skill_level_name, value: skill
  end

  def display_result(dice)
    output icon: '🧮', description: 'Result', value: result_value(dice)
  end

  def random_dice
    Array.new(4) { Random.rand(-1..1) }
  end

  def result_value(dice)
    result = dice.sum
    result += skill unless skill.nil?
    result
  end

  def output(icon: nil, description: nil, value: nil)
    format OUTPUT_TEMPLATE, icon: icon, description: description, value: value
  end

  def skill_level_name
    if skill <= -2
      SKILL_LEVEL[-2]
    elsif skill >= 8
      SKILL_LEVEL[8]
    else
      SKILL_LEVEL[skill]
    end
  end
end

module Commands
  module Fate
    extend Discordrb::Commands::CommandContainer

    command :fate,
            description: 'Roll a set of fate dice and see the result! '\
                         'Accepts an optional skill level and description',
            usage:       'fate [skill level] [description]' do |event, skill = nil, *args|
      break if Settings.public_channel?(event.channel)

      description = args.join(' ')
      event << "**#{event.user.nickname} Fate Roll**"
      event << "*#{description}*" unless description.blank?
      event << '```'
      event << FateDice.roll(skill)
      event << '```'
    end
  end
end
