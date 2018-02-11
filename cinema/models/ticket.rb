require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :movie_id, :customer_id, :screening_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end


  def save()

    sql = "INSERT INTO tickets(movie_id, customer_id, screening_id)
          VALUES($1, $2, $3)
          RETURNING id"
    values = [@movie_id, @customer_id, @screening_id]
    ticket = SqlRunner.run(sql,values).first
    @id = ticket['id'].to_i

    sql = "UPDATE screenings
          SET tickets_left = (tickets_left - $1)
          WHERE screenings.id = $2"
    values = [1, @screening_id]
    SqlRunner.run(sql,values)

  end


  def update()
    sql = "UPDATE tickets
          SET (customer_id, movie_id, screening_id) = ($1, $2, $3)
          WHERE id = $4"
    values = [@movie_id, @customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM tickets
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def movies()
    sql = "SELECT *
          FROM movies
          WHERE id = $1"
    values = [@movie_id]
    movie = SqlRunner.run(sql,values)[0]
    return Movie.new(Movie)
  end


  def customers()
    sql = "SELECT *
          FROM customers
          WHERE id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql,values)[0]
    return Customer.new(customer)
  end


  def update_funds()
    sql = "SELECT *
          FROM movies
          WHERE id = $1"
    values = [@movie_id]
    movie = Movie.new(SqlRunner.run(sql,values)[0])
    price = movie.price.to_i

    sql = "UPDATE customers
          SET funds = (funds - $1)
          WHERE id = $2"
    values = [price, @customer_id]
    SqlRunner.run(sql,values)
  end


  def self.all()
    sql = "SELECT *
          FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map {|ticket| Ticket.new(ticket)}
    return result
  end


  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
