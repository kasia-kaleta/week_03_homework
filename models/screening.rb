require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :film_id, :screening_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @screening_time = options['screening_time'].to_i
  end

end 
