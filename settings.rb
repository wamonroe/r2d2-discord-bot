class Settings
  class << self
    # Read the list of public channel ids
    def public_channel_ids
      @public_channel_ids ||= ENV['R2D2_PUBLIC_CHANNELS'].to_s.split(',').map(&:to_i)
    end

    def public_channel?(channel)
      public_channel_ids.include?(channel.id)
    end

    # Read the list of names to create commands for from the environment.
    #
    #   * A name should be specified as all lowercase
    #   * A name should only contain letters, numbers, and underscores
    #   * Gender can be specified by appending `:f` or `:m` to the name
    #   * Multiple names can specified as a comma seperated list
    #   * Avoid spaces around colons when specifying gender
    #   * Avoid spaces around commas when listing multiple names
    #
    # Example:
    #
    #   export R2D2_MOST_INTERESTING=susie:f,bob:m,janet:f
    #
    # The resulting list stored to the variable people will look like:
    #
    #   [[:susie, "f"], [:bob, "m"], [:janet, "f"]]
    #
    def interesting_people
      @interesting_people ||=
        ENV['R2D2_MOST_INTERESTING'].to_s.split(',').map do |entry|
          name, gender = entry.split(':')

          # normalize name and gender
          name = name.downcase.strip.gsub(/\s+/, '_').gsub(/\W+/, '').to_sym
          gender = gender.nil? ? 'm' : gender.downcase.strip[0]

          # put together results
          [name, gender]
        end
    end
  end
end
