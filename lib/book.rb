class Book
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    all_books = []
    result = DB.exec("SELECT * FROM books;")
    result.each() do |book|
      name = book.fetch('name')
      id = book.fetch('id').to_i()
      all_books.push(Book.new({:name => name, :id => id}))
  end
  all_books
 end

 define_singleton_method(:find) do |id|
 @id = id
 result = DB.exec("SELECT * FROM books WHERE id = #{id};")
 @name = result.first().fetch("name")
 Book.new({:name => @name, :id => @id})
end

    define_method(:save) do
      result = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_method(:==) do |other_book|
      self.name().==(other_book.name()).&(self.id().==(another_book.id()))
    end

    define_method(:update) do |attributes|
      @name = attributes.fetch(:name, @name)
      DB.exec("UPDATE books SET name = '#{@name}' WHERE id = #{self.id()};")

      attributes.fetch(:author_ids, []).each() do |author_id|
        DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author_id}, #{self.id()});")
      end
    end

    define_method(:delete) do
    DB.exec("DELETE FROM authors_books WHERE book_id = #{self.id()};")
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end

    define_method(:authors) do
      author_books =[]
      results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{self.id()};")
      results.each() do |result|
        author_id = result.fetch("author_id").to_i()
        author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
        name = author.first().fetch("name")
        author_books.push(Author.new({:name => name, :id => author_id}))
      end
      author_books
    end

    define_singleton_method(:search) do |search_title|
      found_books = []
      results = DB.exec("SELECT * FROM books WHERE name LIKE '%#{search_title}'")
      results.each()do |result|
      id = result.fetch("id").to_i()
      name = result.fetch("name")
      found_books.push(Book.new({:name => name, :id => id}))
    end
    found_books
  end
  end
