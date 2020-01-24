require_relative('../db/sql_runner.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save() #CREATE
    sql = "INSERT INTO films (title, price) VALUES
           ($1, $2) RETURNING id"
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all() #READ
    sql = "SELECT * FROM films"
    result = SqlRunner.run(sql)
    films = result.map{|film| Film.new(film)}
    return films
  end

  def update() #UPDATE
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @funds, @id]
    result = SqlRunner.run(sql, values)
  end

  def self.delete_all() #DELETE ALL
    sql = "DELETE FROM films"
    result = SqlRunner.run(sql)
  end

  def delete() #DELETE
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def customers() #FINDS CUSTOMERS
    sql = "SELECT * FROM customers
          INNER JOIN tickets
          ON customers.id = tickets.customer_id
          WHERE tickets.film_id = $1"
    values = [@id]
    customers_data = SqlRunner.run(sql, values)
    result = customers_data.map{|customer| Customer.new(customer)}
    return result
  end

end
