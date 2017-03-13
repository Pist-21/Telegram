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
      when '/day'
        answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: [%w(Понеділок Вівторок), %w(Середа Четвер Пятниця)], one_time_keyboard: true)
        bot.api.send_message( chat_id:message.chat.id, text: Dayquestion,reply_markup:answers)


      when 'Понеділок'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectday("pist1","Monday"))
      when 'Вівторок'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectday("pist1","Thuesday"))
      when 'Середа'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectday("pist1","Wednesday"))
      when 'Четвер'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectday("pist1","Thursday"))
      when 'Пятниця'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectday("pist1","Friday"))


      else
        bot.api.send_message(
        chat_id:message.chat.id,
        text:"Невідома команда -->  " + "\"" + message.text + "\"" + "\n\n" + Availablecommands)
    end
  end
end
