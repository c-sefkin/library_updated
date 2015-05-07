class Patron
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec('SELECT * FROM patrons;')
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch('name')
      id = patron.fetch('id').to_i()
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM patrons WHERE id = #{@id};")
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

  # define_method(:update) do |attributes|
  #   @name = attributes.fetch(:name, @name)
  #   @id = self.id()
  #   DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
  #
  #   attributes.fetch(:patron_ids, []).each() do |patron_id|
  #     DB.exec("INSERT INTO checkout (patron_id, patron_id) VALUES (#{patron_id}, #{self.id()});")
  #   end
  # end

  define_method(:delete) do
    DB.exec("DELETE FROM checkout WHERE id = #{self.id()};")
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end

  # define_method(:copies) do
  #   patron_copies =[]
  #   results = DB.exec("SELECT patron_id FROM checkout WHERE patron_id = #{self.id()};")
  #   results.each() do |result|
  #     patron_id = result.fetch("patron_id").to_i()
  #     patron = DB.exec("SELECT * FROM copies WHERE id = #{patron_id};")
  #     name = patron.first().fetch("name")
  #     patron_patrons.push(patron.new({:name => name, :id => patron_id}))
  #   end
  #   patron_patrons
  # end

  # define_method(:delete) do
  #   DB.exec("DELETE FROM patrons WHERE id = #{self.id()}")
  # end
end
