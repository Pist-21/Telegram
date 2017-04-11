require "telegram/bot"
require "date"
require "redis"
require "timeout"

require_relative "lib/base"
require_relative "lib/reset"
require_relative "lib/semester"
require_relative "lib/status"
require_relative "lib/subject"
require_relative "lib/submit"

token = '376993256:AAFpGwO_kYCzrYtZIssaw9fTzzWNihBJbWc'

SKILLS = "Привіт. Я сможу допомогти тобі здати всі лаби.
Список того, що я вмію:\n
/start - стартова команда. Виводить опис всіх доспутних команд
/semester - запам'ятовує дати початку і кінця семестру
/subject - добавляє предмет і кількість лабораторних робіт по ньому
/status - виводить список твоїх лаб, які ще потрібно здати
/reset - скинує всі дані
/submit - запам'ятовує зданий предмет".freeze

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when "/start"
      bot.api.sendMessage(chat_id: message.chat.id, text: SKILLS)
    when "/semester"
      semester = Semester.new(bot, message.chat.id)
      semester.send_messages
    when "/subject"
      subject = Subject.new(bot, message.chat.id)
      subject.send_messages
    when "/status"
      status = Status.new(bot, message.chat.id)
      status.send_messages
    when "/reset"
      reset = Reset.new(bot, message.chat.id)
      reset.reset_redis
    when "/submit", /я здав?/
      submit = Submit.new(bot, message.chat.id)
      submit.send_messages
    end
  end
end
