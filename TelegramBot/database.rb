require 'sqlite3'

def dbconnect(dbname, day)
  strlessons = ""
  begin
    db = SQLite3::Database.new "database/#{dbname}.db"
      for i in db.execute("select * from #{day}")
          strlessons = strlessons + i.to_s + "\n"
      end
    return strlessons
  rescue
    puts "Error: wrong command! (dbname -> '#{dbname}' or day -> '#{day}')"
    File.delete("database/#{dbname}.db")
    return
  end
end

puts dbconnect('pist6','Friday')
