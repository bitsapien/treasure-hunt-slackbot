require "sqlite3"

db = SQLite3::Database.new "bot.db"

# Create a table
db.execute <<-SQL
  create table score_events (
    id INTEGER PRIMARY KEY   AUTOINCREMENT,
    created_at DATE DEFAULT (datetime('now','localtime')),
    from_level INTEGER,
    team VARCHAR(50)
  );
SQL

db.execute <<-SQL
  create table events (
    id INTEGER PRIMARY KEY   AUTOINCREMENT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    what varchar(30),
    msg varchar(1000),
    team varchar(50)
  );
SQL
