class Patron
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    all_patrons = []
    result = DB.exec("SELECT * FROM patrons;")
    result.each() do |patron|
      name = patron.fetch('name')
      id = patron.fetch('id').to_i()
      all_patrons.push(Patron.new({:name => name, :id => id}))
    end
    all_patrons
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM patrons WHERE id = #{id};")
    @name = result.first().fetch("name")
    Patron.new({:name => @name, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patron|
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:book_ids, []).each() do |book_id|
      due_date = Time.new() + (2*7*24*60*60)
      new_checkout = Checkout.new({:id => nil, :book_id => book_id, :patron_id => @id, :due_date => due_date})
      new_checkout.save()
    end
  end

  define_method(:check_out) do
    patron_checkouts = []
    results = DB.exec("SELECT * FROM checkouts WHERE patron_id = #{self.id()};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      patron_id = result.fetch("patron_id").to_i()
      due_date = result.fetch("due_date")
      id = result.fetch("id").to_i()
      patron_checkouts.push(Checkout.new({:book_id => book_id, :patron_id => patron_id, :id => id, :due_date => due_date}))
    end
    patron_checkouts
  end


  define_singleton_method(:search) do |search_name|
    found_patrons = []
    results = DB.exec("SELECT * FROM patrons WHERE name LIKE '%#{search_name}';")
  end


  define_method(:delete) do
    DB.exec("DELETE FROM checkouts WHERE patron_id = #{self.id()};")
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end

end
