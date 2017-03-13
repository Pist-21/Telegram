$LOAD_PATH << '.'
require 'telegram/bot'
require 'config.rb'
require 'date'
require 'sqlite3'
require 'database.rb'

starttext = "Привіт. Я бот, який допоможе тобі дізнатись розклад занять.\n
Список доступних команд:
/start - виводить привітання, яке ти зараз бачиш
/today - розклад на сьогодні
/day - розклад на заданий день
/week - розклад на тиждень ".freeze

currentday = Time.now.strftime('%A').to_s

Telegram::Bot::Client.run(Token) do |bot|
  bot.listen do |message|
    case message.text
      when '/start'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:starttext)
      when '/today'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectday("pist1",currentday))
      when '/week'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectweek("pist1"))
    end
  end
end
