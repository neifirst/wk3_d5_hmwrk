require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :movie_id, :screen_time

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @screen_time = options['screen_time']
  end


  def save()
    sql = "INSERT INTO screenings(movie_id, screen_time)
          VALUES($1, $2)
          RETURNING id"
    values = [@movie_id, @screen_time]
    screening = SqlRunner.run( sql,values ).first
    @id = screening['id'].to_i
  end



  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end



end
