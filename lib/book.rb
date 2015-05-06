class Book
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec('SELECT * FROM books;')
    books = []
    returned_books.each() do |book|
      name = book.fetch('name')
      id = book.fetch('id').to_i()
      books.push(Book.new({:name => name, :id => id}))
  end
  books
 end

    define_singleton_method(:find) do |id|
      @id = id
      result = DB.exec("SELECT * FROM books WHERE id = #{@id};")
      @name = result.first().fetch("name")
      Book.new({:name => @name, :id => @id})
    end

    define_method(:save) do
      result = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_method(:==) do |another_book|
      self.name().==(another_book.name()).&(self.id().==(another_book.id()))
    end

    define_method(:update) do |attributes|
      @name = attributes.fetch(:name, @name)
      @id = self.id()
      DB.exec("UPDATE books SET name = '#{@name}' WHERE id = #{@id};")

      attributes.fetch(:author_ids, []).each() do |author_id|
        DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author_id}, #{self.id()});")
      end
    end

    define_method(:delete) do
      DB.exec("DELETE FROM authors_books WHERE id = #{self.id()};")
      DB.exec("DELETE FROM books WHERE id = #{self.id()};")
    end

    define_method(:authors) do
      book_authors =[]
      results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{self.id()};")
      results.each() do |result|
        author_id = result.fetch("author_id").to_i()
        author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
        name = author.first().fetch("name")
        book_authors.push(Author.new({:name => name, :id => author_id}))
      end
      book_authors
    end

    define_method(:delete) do
      DB.exec("DELETE FROM books WHERE id = #{self.id()}")
    end
  end
