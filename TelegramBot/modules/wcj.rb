require 'json'
require 'uri'
require 'open-uri'
require 'tempfile'
require 'net/http'
require 'nokogiri'


class BotFunc

  def say_hello bot, message, params_
    bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
  end

  def help_me bot, message, params_
    commands = File.open('commands.txt') { |file| file.read }
    bot.api.sendMessage(chat_id: message.chat.id, text: commands)
  end

  def say_i_dont_know bot, message, params_
    bot.api.sendMessage(chat_id: message.chat.id, text: "I don't know what you mean, #{message.from.first_name}")
  end

  def say_me_weather bot, message, params_

    city = params_[1]

    city = (city.nil? ? "Odessa" : city)

    if city.ascii_only?

      url = URI("http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=metric&appid=#{w_token}")

      http = Net::HTTP.new(url.host, url.port)

      request = Net::HTTP::Get.new(url)
      request["cache-control"] = 'no-cache'
      request["postman-token"] = '5ca1aff9-57ae-6c0c-40b1-49a2997854fd'

      response = http.request(request)
      body = JSON.parse response.read_body
      bot.api.sendMessage(chat_id: message.chat.id, text:  "#{body['name']},#{body['sys']['country']}\nThe temperature is #{body["main"]["temp"]} °C")

    else
      bot.api.sendMessage(chat_id: message.chat.id, text:  "Error! \nWrite the correct name of the city in English!")

    end

  end

  def say_me_exchange_rate bot, message, params_

    url = URI("http://openrates.in.ua/rates")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '60ae9115-8127-c9b7-93da-c09f9e6fc80f'

    emoji = {
            "bank" => "🏦",
            "sell" => "⏫",
            "buy" => "⏬",
            "UAH" => "🇺🇦",
            "USD" => "💵",
            "EUR" => "💶",
            "RUB" => "🇷🇺"
            }

    response = http.request(request)
    body = JSON.parse response.read_body
    resp = "Exhange rate for UAH #{emoji['UAH']}";
    body.each_key do |k_curr|
      resp = resp + "\n\n#{emoji[k_curr]}#{k_curr}:"
      body[k_curr].each_key do |k_bank|
        resp = resp + "\n#{emoji['bank']}#{k_bank}:\n"
        body[k_curr][k_bank].each_key do |k_rate|
          resp = resp + "#{emoji[k_rate]}#{k_rate}: #{format("%.2f", body[k_curr][k_bank][k_rate])}\t"
        end
      end
    end
    bot.api.sendMessage(chat_id: message.chat.id, text: resp)

  end

  def give_me_cat_image bot, message, params_

    open(Tempfile.new(['img', '.jpg']).path, 'wb') do |file|
      file << open('http://lorempixel.com/400/400/cats/').read
      bot.api.send_photo(chat_id: message.chat.id, photo: Faraday::UploadIO.new(file.path, 'image/jpeg'))
    end

  end

  def give_me_just_image bot, message, params_

    open(Tempfile.new(['img', '.jpg']).path, 'wb') do |file|
      file << open('http://lorempixel.com/400/400/').read
      bot.api.send_photo(chat_id: message.chat.id, photo: Faraday::UploadIO.new(file.path, 'image/jpeg'))
    end

  end

  def make_me_laugh bot, message, params_

    html = open("http://bash.im/random")
    doc = Nokogiri::HTML(html)

    doc.search('br').each do |n|
      n.replace("\n")
    end


    count = params_[1].nil? ? 5 : params_[1].to_i

    doc.css('.quote').each do |quote|
      quote.css('.text').each do |text|
        bot.api.sendMessage(chat_id: message.chat.id, text: text.text)
        count = count - 1
        if count == 0 then
          return
        end
      end
    end
  end

  def say_good_bye bot, message, params_
    bot.api.sendMessage(chat_id: message.chat.id, text: "Good Bye, #{message.from.first_name}")
  end


  private
  def w_token
    config = File.open('config.json') { |file| file.read }
    hConfig = JSON.parse config
    hConfig['wToken']
  end

end
