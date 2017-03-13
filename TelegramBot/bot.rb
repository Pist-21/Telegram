$LOAD_PATH << '.'
require 'telegram/bot'
require 'config.rb'
require 'date'
require 'sqlite3'
require 'database.rb'
require 'commands.rb'

currentday = Time.now.strftime('%A').to_s

Telegram::Bot::Client.run(Token) do |bot|
  bot.listen do |message|
    case message.text
      when '/start'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:Hello + "\n" + Availablecommands)
      when '/today'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectday("pist1",currentday))
      when '/week'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectweek("pist1"))
      else
        bot.api.send_message(
        chat_id:message.chat.id,
        text:"Невідома команда -->  " + "\"" + message.text + "\"" + "\n\n" + Availablecommands)
    end
  end
end
