$LOAD_PATH << '.'
require 'telegram/bot'
require 'config.rb'
require 'date'
require 'sqlite3'
require 'database.rb'
require 'commands.rb'

current_day = Time.now.strftime('%A').to_s

Telegram::Bot::Client.run(Token) do |bot|
  bot.listen do |message|
    case message.text

      when '/start'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:Hello + "\n" + Availablecommands)

      when '/lessons'
        group = "ПІст-21 ПІ-31 ПІ-32 ПІ-33 ПІ-34"
        group_split = group.split(" ")
        answer = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: group_split, one_time_keyboard: true)
        bot.api.send_message(chat_id:message.chat.id,text:"Виберіть групу: ", reply_markup:answer)
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
      when 'ПІст-21', 'ПІ-31', 'ПІ-32', 'ПІ-33', 'ПІ-34'
        @picked_group = message.text
        period = "Сьогодні Тиждень День"
        period_split = period.split(" ")
        answer = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: period_split, one_time_keyboard: true)
        bot.api.send_message(chat_id:message.chat.id,text:"Виберіть період: ", reply_markup:answer)
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
      when 'Сьогодні'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectday(@picked_group, current_day))

      when 'Тиждень'
        bot.api.send_message(
        chat_id:message.chat.id,
        text:dbconnectweek(@picked_group))

      when 'День'
        day = "Понеділок Вівторок Середа Четвер П'ятниця"
        day_split = day.split(" ")
        answer = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: day_split, one_time_keyboard: true)
        bot.api.send_message(chat_id:message.chat.id,text:"Виберіть день: ", reply_markup:answer)

      when "Понеділок", "Вівторок", "Середа", "Четвер", "П'ятниця"
          @picked_day = message.text
          if @picked_day == "Понеділок"
              @picked_day = "Monday"
          elsif @picked_day == "Вівторок"
              @picked_day = "Thuesday"
          elsif @picked_day == "Середа"
              @picked_day = "Wednesday"
          elsif @picked_day == "Четвер"
              @picked_day = "Thursday"
          elsif @picked_day == "П'ятниця"
              @picked_day = "Friday"
          end
          bot.api.send_message(chat_id:message.chat.id,text:dbconnectday(@picked_group, @picked_day))
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
      else
        bot.api.send_message(
        chat_id:message.chat.id,
        text:"Невідома команда -->  " + "\"" + message.text + "\"" + "\n\n" + Availablecommands)
    end
  end
end
