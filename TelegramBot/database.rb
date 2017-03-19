require 'sqlite3'

def dbconnectday(dbname, day)
  strlessons = ""
  begin
    db = SQLite3::Database.new "database/#{dbname}.db"
      for i in db.execute("select * from #{day}")
          strlessons = strlessons + i.to_s + "\n"
      end
      returnvar = "#{day}\n\n" + strlessons
      newvar = returnvar.gsub("\"",'')
    return newvar
  rescue
    puts "Error: wrong command! (dbname -> '#{dbname}' or day -> '#{day}')"
    return "oops"
  end
end

def dbconnectweek(dbname)
  sMonday = ""
  sThuesday = ""
  sWednesday = ""
  sThursday = ""
  sFriday = ""
  week = ""
  begin
    db = SQLite3::Database.new "database/#{dbname}.db"
      for i in db.execute("select * from Monday")
          sMonday = sMonday + i.to_s + "\n"
      end
      for i in db.execute("select * from Thuesday")
          sThuesday = sThuesday + i.to_s + "\n"
      end
      for i in db.execute("select * from Wednesday")
          sWednesday = sWednesday + i.to_s + "\n"
      end
      for i in db.execute("select * from Thursday")
          sThursday = sThursday + i.to_s + "\n"
      end
      for i in db.execute("select * from Friday")
          sFriday = sFriday + i.to_s + "\n"
      end
      week = "Понеділок\n #{sMonday}\nВівторок\n#{sThuesday}
Середа\n#{sWednesday}\nЧетвер\n#{sThursday}
П'ятниця\n #{sFriday}".freeze
    return week
  rescue
    puts "Error: wrong command! (dbname -> '#{dbname}')"
    return "oops"
  end
end
