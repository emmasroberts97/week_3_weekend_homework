require_relative('../db/sql_runner.rb')

class Ticket

  attr_accessor :film_id, :customer_id, :screen_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @customer_id = options['customer_id']
    @screen_id = options['screen_id']
  end

  def save() #CREATE
    sql = "INSERT INTO tickets (film_id, customer_id, screen_id) VALUES
           ($1, $2, $3) RETURNING id"
    values = [@film_id, @customer_id, @screen_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all() #READ
    sql = "SELECT * FROM tickets"
    result = SqlRunner.run(sql)
    tickets = result.map{|ticket| Ticket.new(ticket)}
    return tickets
  end

  def update() #UPDATE
    sql = "UPDATE tickets SET (film_id, customer_id, screen_id) = ($1, $2, $3) WHERE id = $4"
    values = [@film_id, @customer_id, @screen_id, @id]
    result = SqlRunner.run(sql, values)
  end

  def self.delete_all() #DELETE ALL
    sql = "DELETE FROM tickets"
    result = SqlRunner.run(sql)
  end

  def delete() #DELETE
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

end
