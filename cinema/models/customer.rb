require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end



  def save()
    sql = "INSERT INTO customers(name, funds)
          VALUES($1, $2)
          RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end


  def update()
    sql = "UPDATE customers
          SET (name, funds) = ($1, $2)
          WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM customers
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def movies()

    sql = "SELECT movies.*
          FROM movies
          INNER JOIN tickets
          ON movies.id = tickets.movie_id
          WHERE customer_id = $1;"
    values = [@id]
    movies = SqlRunner.run(sql, values)
    return movies.map {|movie| Movie.new(movie)}

  end


  def tickets()

    sql = "SELECT *
          FROM tickets
          WHERE customer_id = $1;"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets.count

  end


  def self.all()
    sql = "SELECT *
          FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map {|customer| Customer.new(customer)}
    return result
  end


  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

end
