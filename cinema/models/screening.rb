require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :movie_id, :screen_time, :tickets_left

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @screen_time = options['screen_time']
    @tickets_left = options['tickets_left']
  end


  def save()
    sql = "INSERT INTO screenings(movie_id, screen_time, tickets_left)
          VALUES($1, $2, $3)
          RETURNING id"
    values = [@movie_id, @screen_time, @tickets_left]
    screening = SqlRunner.run(sql,values).first
    @id = screening['id'].to_i
  end


  def update()
    sql = "UPDATE screenings
          SET (movie_id, screen_time, tickets_left) = ($1, $2, $3)
          WHERE id = $4"
    values = [@title, @price, @tickets_left, @id]
    SqlRunner.run(sql, values)

  end


  def delete()
    sql = "DELETE FROM screenings
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def check_availability()

    sql = "SELECT screenings.tickets_left
          FROM screenings
          WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)
    amount = result.map {|x| x["tickets_left"].to_i}
    return true if amount[0] > 0

  end
  

  def self.all()
    sql = "SELECT *
          FROM screenings"
    values = []
    screenings = SqlRunner.run(sql, values)
    result = screenings.map {|screening| Screening.new(screening)}
    return result
  end


  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end



end
