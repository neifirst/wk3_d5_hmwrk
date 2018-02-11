require_relative("../db/sql_runner")

class Movie

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )

    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']

  end



  def save()
    sql = "INSERT INTO movies(title, price)
          VALUES ($1, $2)
          RETURNING id"
    values = [@title, @price]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end


  def update()
    sql = "UPDATE movies
          SET (title, price) = ($1, $2)
          WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)

  end


  def delete()
    sql = "DELETE FROM movies
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def audience_details()

    sql = "SELECT customers.*
          FROM customers
          INNER JOIN tickets
          ON customers.id = tickets.customer_id
          WHERE movie_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map {|customer| Customer.new(customer)}

  end


  def audience_size()

    sql = "SELECT *
          FROM tickets
          WHERE movie_id = $1;"
    values = [@id]
    audience = SqlRunner.run(sql, values)
    return audience.count

  end


  def times()

    sql = "SELECT screen_time
          FROM screenings
          WHERE movie_id = $1;"
    values = [@id]
    screenings = SqlRunner.run(sql, values)
    return screenings.map {|screening| Screening.new(screening)}

  end


  def most_pop_screening()

    sql = "SELECT tickets.screening_id
          FROM tickets
          WHERE tickets.movie_id = $1;"
    values = [@id]
    result = (SqlRunner.run(sql, values)).uniq
    times = result.map {|x| x["screening_id"].to_i}

    count = 1
    quantity = []

    while count <= times.length

      sql = "SELECT tickets.screening_id
            FROM tickets
            WHERE tickets.movie_id = $1 AND tickets.screening_id = $2;"
      values = [@id, count]
      result = (SqlRunner.run(sql, values))
      quantity << result.to_a
      count += 1

    end

    return (quantity.max_by {|array| array.length}).uniq

  end


  def least_pop_screening()

    sql = "SELECT tickets.screening_id
          FROM tickets
          WHERE tickets.movie_id = $1;"
    values = [@id]
    result = (SqlRunner.run(sql, values)).uniq
    times = result.map {|x| x["screening_id"].to_i}

    count = 1
    quantity = []

    while count <= times.length

      sql = "SELECT tickets.screening_id
            FROM tickets
            WHERE tickets.movie_id = $1 AND tickets.screening_id = $2;"
      values = [@id, count]
      result = (SqlRunner.run(sql, values))
      quantity << result.to_a
      count += 1

    end

    return (quantity.min_by {|array| array.length}).uniq

  end


  def self.all()
    sql = "SELECT *
          FROM movies"
    values = []
    movies = SqlRunner.run(sql, values)
    result = movies.map {|movies| Movie.new( movie )}
    return result
  end


  def self.delete_all()
    sql = "DELETE FROM movies"
    values = []
    SqlRunner.run(sql, values)
  end

end
