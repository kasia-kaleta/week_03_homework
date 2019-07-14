require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :film_id, :screening_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @screening_time = options['screening_time']
  end

  # Creates and saves data in screenings table:
  def save()
    sql = "INSERT INTO screenings(film_id, screening_time)
    VALUES ($1, $2)
    RETURNING id"
    values = [@film_id, @screening_time]
    screening = SqlRunner.run(sql, values)[0];
    @id = screening['id'].to_i
  end

  # Updates screenings table:
  def update()
    sql = "UPDATE screenings SET (film_id, screening_time) = ($1, $2) WHERE id = $3"
    values = [@film_id, @screening_time, @id]
    SqlRunner.run(sql, values)
  end

  # Mapping data from screenings table to new Screening objects:
  def self.all()
    sql = "SELECT * FROM screenings"
    data = SqlRunner.run(sql)
    return data.map{|screening| Screening.new(screening)}
  end

end
