require 'sqlite3'

def dbconnect(dbname, day)
  strlessons = ""
  db = SQLite3::Database.new "database/#{dbname}.db"
  for i in db.execute("select * from #{day}")
    strlessons = strlessons + i.to_s + "\n"
  end
  return strlessons
end

puts dbconnect('pist1','Friday')
