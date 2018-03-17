class FacebookMessengerService
  class << self
    def deliver(uid, message)
      puts "[debuz] sending '#{message}' to user '#{uid}'"
      message_content = {
        text: message,
        quick_replies: quick_replies ? quick_replies : nil
      }
      begin
        Bot.deliver(
          {
            recipient: {
              id: uid
            },
            message: message_content
          },
          access_token: ENV['ACCESS_TOKEN']
        )
      rescue => e
        puts '[debuz] ' + e.message
      end
    end
  end
end
