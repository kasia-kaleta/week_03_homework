require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

# Creates and saves data in customers table:
  def save()
    sql = "INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0];
    @id = customer['id'].to_i
  end

# Updates customer information in the table:
  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

# Lists rows from cutomers table as an array:
  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    return Customer.map_items(customer_data)
  end

# Show which films customers booked:
  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return Film.map_items(film_data)
  end

# Deletes entries from customers table based on the id:
  def delete()
    sql = "DELETE * FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# Mapping data from customers table to new Customer objects:
  def self.map_items(data)
    result = data.map{|customer| Customer.new(customer)}
    return result
  end

# Function for buying ticket by a customer:
  def buy_ticket(film)
    if @funds >= film.price
      ticket = Ticket.new({
      'screening_id' => screening.id,
      'customer_id' => @id
      })
      ticket.save()
      deduct_funds_for_ticket(film)
    end
  end

# Decreases customers funds by the price of the ticket:
  def deduct_funds_for_ticket(film)
    if @funds >= film.price
      @funds -= film.price
      update()
    end
  end

  # Checks how many tickets were bought by customer:
  def get_num_tickets()
    sql = "SELECT tickets.* FROM tickets WHERE customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.count
  end

# Deletes all entries from customers table:
  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  end
