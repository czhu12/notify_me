# frozen_string_literal: true
# app/bot/listen.rb
require 'facebook/messenger'
include Facebook::Messenger

#Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  request_message = message.text
  uid = message.sender['id']
  User.find_or_create_by(uid: uid)  
  unless request_message.nil?
    chat_service = ChatService.new(uid)
    chat_service.execute(request_message)
    FacebookMessengerService.deliver(uid, chat_service.response_message)
  end
end
