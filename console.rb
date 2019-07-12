require_relative('models/film')
require_relative('models/customer')
require_relative('models/ticket')

require('pry-byebug')

film1 = Film.new({
  'title' => 'Spiderman Far from home',
  'price' => 8
  })
film1.save()

binding.pry
nil
