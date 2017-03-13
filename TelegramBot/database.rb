require 'sqlite3'

def dbconnectday(dbname, day)
  strlessons = ""
  begin
    db = SQLite3::Database.new "database/#{dbname}.db"
      for i in db.execute("select * from #{day}")
          strlessons = strlessons + i.to_s + "\n"
      end
    return "#{day}\n\n" + strlessons
  rescue
    puts "Error: wrong command! (dbname -> '#{dbname}' or day -> '#{day}')"
    File.delete("database/#{dbname}.db")
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
      week = "Понеділок\n" + sMonday + "\n" + "Вівторок\n" + sThuesday + "\n" +
              "Середа\n" + sWednesday + "\n" +
              "Четвер\n" + sThursday + "\n" + "П'ятниця\n" + sFriday
    return week
  rescue
    puts "Error: wrong command! (dbname -> '#{dbname}')"
    #File.delete("database/#{dbname}.db")
    return "oops"
  end
end

dbconnectweek("pist1")
