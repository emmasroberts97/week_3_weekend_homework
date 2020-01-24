require_relative('../db/sql_runner.rb')

class Screening

  attr_accessor :showtime
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @showtime = options['showtime']
    @ticket_limit = 5
  end

  def save() #CREATE
    sql = "INSERT INTO screenings (showtime) VALUES
           ($1) RETURNING id"
    values = [@showtime]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all() #READ
    sql = "SELECT * FROM screenings"
    result = SqlRunner.run(sql)
    screenings = result.map{|film| Film.new(film)}
    return screenings
  end

  def update() #UPDATE
    sql = "UPDATE screenings SET showtime = $1 WHERE id = $2"
    values = [@showtime, @id]
    result = SqlRunner.run(sql, values)
  end

  def self.delete_all() #DELETE ALL
    sql = "DELETE FROM screenings"
    result = SqlRunner.run(sql)
  end

  def delete() #DELETE
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

 def remaining_seats() #ticket limit
    taken_seats = 0
    sql = "SELECT COUNT(screen_id) FROM tickets WHERE tickets.screen_id =$1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    taken_seats += results[0]['count'].to_i
    return @ticket_limit - taken_seats
  end

end
