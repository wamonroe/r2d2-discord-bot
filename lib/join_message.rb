module JoinMessage
  extend Discordrb::EventContainer

  member_join do |event|
    break unless (channel = event.server.system_channel)

    channel.send_message "Hey #{event.user.mention}, welcome to **#{event.server.name}**! "\
      "If you are a friend or family member, message #{event.server.owner.mention} "\
      'to be added to the rest of our channels!'
  end
end
