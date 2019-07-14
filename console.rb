require_relative('models/film')
require_relative('models/customer')
require_relative('models/ticket')

require('pry-byebug')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

film1 = Film.new({
  'title' => 'Spiderman Far from home',
  'price' => 8
  })
film1.save()

film2 = Film.new({
  'title' => 'Midsommar',
  'price' => 8
  })
film2.save()

film3 = Film.new({
  'title' => 'Yesterday',
  'price' => 8
  })
film3.save()

customer1 = Customer.new({
  'name' => 'Billy',
  'funds' => 15
  })
customer1.save()

customer2 = Customer.new({
  'name' => "Angie",
  'funds' => 30
  })
customer2.save()

customer3 = Customer.new({
  'name' => 'Carly',
  'funds' => 100
  })
customer3.save()

ticket1 = Ticket.new({
  'film_id' => film1.id,
  'customer_id' => customer1.id,
  })

ticket2 = Ticket.new({
  'film_id' => film2.id,
  'customer_id' => customer2.id,
  })

ticket3 = Ticket.new({
  'film_id' => film3.id,
  'customer_id' => customer3.id,
})

ticket1.save()
ticket2.save()
ticket3.save()



binding.pry
nil
