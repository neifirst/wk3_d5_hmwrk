require_relative( 'models/movie' )
require_relative( 'models/customer' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )

Ticket.delete_all()
Customer.delete_all()
Movie.delete_all()

movie1 = Movie.new({'title' => 'Dark City', 'price' => 8 })
movie1.save()
movie2 = Movie.new({ 'title' => 'The Thing', 'price' => 8 })
movie2.save()
movie3 = Movie.new({ 'title' => 'Leon', 'price' => 8 })
movie3.save()


customer1 = Customer.new({ 'name' => 'Jeniffer', 'funds' => 20})
customer1.save()
customer2 = Customer.new({ 'name' => 'Kieffer', 'funds' => 27})
customer2.save()
customer3 = Customer.new({ 'name' => 'Kurt', 'funds' => 9})
customer3.save()
customer4 = Customer.new({ 'name' => 'Donald', 'funds' => 12})
customer4.save()
customer5 = Customer.new({ 'name' => 'Jean', 'funds' => 42})
customer5.save()
customer6 = Customer.new({ 'name' => 'Gary', 'funds' => 50})
customer6.save()


ticket1 = Ticket.new({ 'movie_id' => movie1.id, 'customer_id' => customer1.id})
ticket1.save()
ticket2 = Ticket.new({ 'movie_id' => movie1.id, 'customer_id' => customer2.id})
ticket2.save()
ticket3 = Ticket.new({ 'movie_id' => movie1.id, 'customer_id' => customer3.id})
ticket3.save()
ticket4 = Ticket.new({ 'movie_id' => movie2.id, 'customer_id' => customer4.id})
ticket4.save()
ticket5 = Ticket.new({ 'movie_id' => movie3.id, 'customer_id' => customer1.id})
ticket5.save()
ticket6 = Ticket.new({ 'movie_id' => movie3.id, 'customer_id' => customer6.id})
ticket6.save()


binding.pry
nil
