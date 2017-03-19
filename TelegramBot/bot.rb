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
      when '/Пари'
        s = "ПІст-21 ПІ-31 ПІ-32 ПІ-33"
        ss = s.split(" ")
        answer = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ss, one_time_keyboard: true)
        bot.api.send_message(chat_id:message.chat.id,text:"Виберіть групу: ", reply_markup:answer)
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
      when 'ПІст-21'
        @yourGroups = message.text
        s = "Сьогодні Тиждень День"
        ss = s.split(" ")
        answer = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ss, one_time_keyboard: true)
        bot.api.send_message(chat_id:message.chat.id,text:"Виберіть період: ", reply_markup:answer)
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
      when 'Сьогодні'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectday(@yourGroups, currentday))
      when 'Тиждень'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectweek(@yourGroups))
      when 'День'
        s = "Понеділок Вівторок Середа Четвер П'ятниця"
        ss = s.split(" ")
        answer = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ss, one_time_keyboard: true)
        bot.api.send_message(chat_id:message.chat.id,text:"Виберіть день: ", reply_markup:answer)
      when "Понеділок", "Вівторок", "Середа", "Четвер", "П'ятниця"
          yourDay = message.text
          if yourDay == "Понеділок"
            yourDay = "Monday"
          end
          bot.api.send_message(chat_id:message.chat.id,text:dbconnectday(@yourGroups, yourDay))
      else
        bot.api.send_message(
        chat_id:message.chat.id,
        text:"Невідома команда -->  " + "\"" + message.text + "\"" + "\n\n" + Availablecommands)
    end
  end
end
