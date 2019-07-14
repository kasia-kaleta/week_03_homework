require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  # Creates and saves data in customers table:
  def save()
    sql = "INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values)[0];
    @id = film['id'].to_i
  end

  # Updates data in films table:
  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  # Lists all rows from films table to an array:
  def self.all()
    sql = "SELECT * FROM films"
    film_data = SqlRunner.run(sql)
    return Film.map_items(film_data)
  end

  # Function that returns which customer comes to see one film:
  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    INNER JOIN screenings
    ON screenings.id = tickets.screening_id
    WHERE film_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return Customer.map_items(customer_data)
  end

  # Checks how many customers are going to watch a certain film:
  def get_num_customers()

    return customers().count
  end


  # Deletes entries from films table based on their id:
  def delete()
    sql = "DELETE * FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # Mapping data from films table to new Film objects:
  def self.map_items(data)
    result = data.map{|film| Film.new(film)}
    return result
  end

  # Deletes all entries from films table:
  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
