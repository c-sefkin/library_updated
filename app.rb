require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/author")
require("./lib/book")
require("./lib/patron")
require("./lib/copy")
require("pg")

DB = PG.connect({:dbname => "library_database"})

get('/') do
  @authors = Author.all()
  @books = Book.all()
  # @copies = Copy.all()
  @patrons = Patron.all()
  erb(:index)
end

get("/authors") do
  @authors = Author.all()
  erb(:authors)
end

get("/books") do
  @books = Book.all()
  erb(:books)
end

post("/authors") do
  name = params.fetch("name")
  author = Author.new({:name => name, :id => nil})
  author.save()
  @authors = Author.all()
  erb(:authors)
end

post("/books") do
  name = params.fetch("name")
  book = Book.new({:name => name, :id => nil})
  book.save()
  @books = Book.all()
  erb(:books)
end

get("/authors/:id") do
  @author = Author.find(params.fetch("id").to_i())
  @books = Book.all()
  erb(:author_info)
end

get("/books/:id") do
  @book = Book.find(params.fetch("id").to_i())
  @authors = Author.all()
  erb(:book_info)
end

patch("/authors/:id") do
  author_id = params.fetch("id").to_i()
  @author = Author.find(author_id)
  book_ids = params.fetch("book_ids")
  @author.update({:book_ids => book_ids})
  @books = Book.all()
  erb(:author_info)
end

patch("/books/:id") do
  book_id = params.fetch("id").to_i()
  @book = Book.find(book_id)
  author_ids = params.fetch("author_ids")
  @book.update({:author_ids => author_ids})
  @authors = Author.all()
  erb(:book_info)
end

delete("/authors/:id") do
  author_id = params.fetch("id").to_i()
  @author = Author.find(author_id)
  book_ids = params.fetch("book_ids")
  @books = Book.all()
  @book.update({:book_ids => book_ids})
  erb(:author_info)
end
