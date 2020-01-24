require('pry')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()


customer1 = Customer.new(
  {
    "name" => "Emma",
    "funds" => "20"
  }
)

customer1.save()

customer1.funds = 30
customer1.update()

customer2 = Customer.new(
  {
    "name" => "Scott",
    "funds" => "30"
  }
)

customer2.save()


film1 = Film.new(
  {
    "title" => "Joker",
    "price" => "10"
  }
)

film1.price = 8
film1.update()

film1.save()

film2 = Film.new(
  {
    "title" => "Grinch",
    "price" => "5"
  }
)

film2.save()

ticket1 = Ticket.new(
  {
    "customer_id" => customer1.id,
    "film_id" => film2.id
  }
)

ticket1.save()

ticket2 = Ticket.new(
  {
    "customer_id" => customer2.id,
    "film_id" => film1.id
  }
)

ticket2.save()

ticket3 = Ticket.new(
  {
    "customer_id" => customer1.id,
    "film_id" => film1.id
  }
)

ticket3.save()

binding.pry
nil
