require 'telegram/bot'
$LOAD_PATH << '.'
require 'config.rb'

Telegram::Bot::Client.run(Token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(
      chat_id:message.chat.id,
      text:"Hello,#{message.from.first_name}")
    end
  end
end
#comment
