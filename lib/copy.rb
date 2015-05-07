class Copy
  attr_reader(:copy, :id)

  define_method(:initialize) do |attributes|
    @copy = attributes.fetch(:copy)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_copies = DB.exec("SELECT * FROM copies;")
    copies = []
    returned_copies.each() do |copy|
      copy = copy.fetch(copy)
      id = copy.fetch("id").to_i()
      copies.push(Copy.new({:copy => copy, :id => nil}))
    end
    copies
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM copies WHERE id = #{@id};")
    @copy = result.first().fetch("copy")
    Copy.new({:copy => @copy, :id => @id})
  end


  define_method(:save) do
    result = DB.exec("INSERT INTO copies (copy) VALUES ('#{@copy}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_copy|
    self.copy().==(another_copy.copy()).&(self.id().==(another_copy.id()))
  end
  #
  # define_method(:update) do |attributes|
  #   @copy = attributes.fetch(:copy, @copy)
  #   @id = self.id()
  #   DB.exec("UPDATE copies SET copy = '#{@copy}' WHERE id = #{@id};")
  #
  #   attributes.fetch(:patron_ids, []).each() do |patron_id|
  #     DB.exec("INSERT INTO checkout (copy_id, patron_id) VALUES (#{self.id()}, #{patron_id});")
  #   end
  # end

  define_method(:delete) do
    DB.exec("DELETE FROM checkout WHERE id = #{self.id()};")
    DB.exec("DELETE FROM copies WHERE id = #{self.id()};")
  end
end

#   define_method(:patrons) do
#     copy_patrons = []
#     results = DB.exec("SELECT patron_id FROM checkout WHERE copy_id = #{self.id()};")
#     results.each() do |result|
#       patron_id = result.fetch("patron_id").to_i()
#       patron = DB.exec("SELECT * FROM patrons WHERE id = #{patron_id};")
#       copy = patron.first().fetch("copy")
#       copy_patrons.push(Patron.new({:copy => copy, :id => patron_id}))
#     end
#     copy_patrons
#   end
# end
