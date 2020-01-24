require_relative('../db/sql_runner.rb')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save() #CREATE
    sql = "INSERT INTO customers (name, funds) VALUES
           ($1, $2) RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all() #READ
    sql = "SELECT * FROM customers"
    result = SqlRunner.run(sql)
    customers = result.map{|customer| Customer.new(customer)}
    return customers
  end

  def update() #UPDATE
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    result = SqlRunner.run(sql, values)
  end

  def self.delete_all() #DELETE ALL
    sql = "DELETE FROM customers"
    result = SqlRunner.run(sql)
  end

  def delete() #DELETE
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def films() #FINDS FILMS 
    sql = "SELECT * FROM films
          INNER JOIN tickets
          ON films.id = tickets.film_id
          WHERE tickets.customer_id = $1;"
    values = [@id]
    films_data = SqlRunner.run(sql, values)
    result = films_data.map{|film| Film.new(film)}
    return result
  end

end
