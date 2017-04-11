# This class inludes semester date
class Semester < Base
  def send_messages
    date1 = ask_about_semester_date("Коли починається навчання?")
    date2 = ask_about_semester_date("Коли потрібно здати всі лаби?")

    if date2 <= date1
      telegram_send_message("Сорі, але ти вже запізнився. Повторка не кінець світу(")
    else
      add_date_to_redis(date1, date2)
      telegram_send_message("Ок, в тебе є #{date_day_difference(date1, date2) / 30} місяця і #{date_day_difference(date1, date2) % 30} день ")
    end
  rescue then telegram_send_message("Ти не вклався. Спробуй ще раз. Або поступай на КН")
  end

  def ask_about_semester_date(question)
    telegram_send_message(question)
    take_new_answer
    until_message_get_date
    Time.parse(messages_array.last)
  end

  def add_date_to_redis(date1, date2)
    user_id = @user_id
    @redis.hmset("#{user_id}-date", "begin", date1)
    @redis.hmset("#{user_id}-date", "end", date2)
    @redis.hmset("#{user_id}-date", "date_differ", date_day_difference(date1, date2))
  end

  def date_day_difference(date1, date2)
    ((date2 - date1) / (3600 * 24)).to_i
  end

  def percent_elements(arr, percent)
    arr.take((arr.size * percent / 100.0).ceil)
  end

  def str_date?(str)
    d, m, y = str.split "."
    Date.valid_date? y.to_i, m.to_i, d.to_i
  end

  def until_message_get_date
    count_try = 10
    count_try.times do
      return if str_date?(messages_array.last)
      telegram_send_message("Введи дату в форматі дд.мм.рр ...")
      take_new_answer
    end
    telegram_send_message("У тебе було #{count_try} спроб написати правильну дату.")
  end
end
