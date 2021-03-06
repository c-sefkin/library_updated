require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/author")
require("./lib/book")
require("./lib/patron")
require("./lib/checkout")
require("pg")

DB = PG.connect({:dbname => "library_database"})

get('/') do
  erb(:index)
end

get('/admin') do
  @books = Book.all()
  @authors = Author.all()
  @overdue_items = Checkout.over_due()
  erb(:admin)
end

get("/books") do
  @books = Book.all()
  erb(:books)
end

post("/books") do
  name = params.fetch("name")
  book = Book.new({:name => name, :id => nil})
  book.save()
  @books = Book.all()
  erb(:books)
end

get("/authors") do
  @authors = Author.all()
  erb(:authors)
end

post("/authors") do
  name = params.fetch("name")
  author = Author.new({:name => name, :id => nil})
  author.save()
  @authors = Author.all()
  erb(:authors)
end

get("/books/:id") do
  id = params.fetch("id").to_i
  @book = Book.find(id)
  @authors = Author.all()
  erb(:book_info)
end

patch("/books/:id") do
  book_id = params.fetch("id").to_i()
  @book = Book.find(book_id)
  author_ids = params.fetch("author_ids", [])
  @book.update({:author_ids => author_ids})
  @authors = Author.all()
  erb(:book_info)
end

delete('/books/:id') do
  book_id = params.fetch("id").to_i()
  book = Book.find(book_id)
  book.delete()
  @books = Book.all()
  erb(:books)
end

get("/authors/:id") do
  id = params.fetch("id").to_i()
  @author = Author.find(id)
  @books = Book.all()
  erb(:author_info)
end

patch("/authors/:id") do
  author_id = params.fetch("id").to_i()
  @author = Author.find(author_id)
  book_ids = params.fetch("book_ids", [])
  @author.update({:book_ids => book_ids})
  @books = Book.all()
  erb(:author_info)
end

delete("/authors/:id") do
  author_id = params.fetch("id").to_i()
  author = Author.find(author_id)
  author.delete()
  @authors = Author.all()
  erb(:authors)
end

post('/books/search') do
  search_term = params.fetch("search_term")
  @books = Book.search(search_term)
  @authors = Author.search(search_term)
  erb(:search_result)
end

get('/patrons') do
  @patrons = Patron.all()
  erb(:patrons)
end

post('/patrons') do
  name = params.fetch("name")
  new_patron = Patron.new({:name => name, :id => nil})
  new_patron.save()
  @patrons = Patron.all()
  erb(:patrons)
end

get('/patrons/:id') do
  patron_id = params.fetch("id").to_i
  @patron = Patron.find(patron_id)
  @checkouts = Checkout.find_by_patron(patron_id)
  @books = Book.all()
  erb(:patron_info)
end

patch('/patrons/:id') do
  patron_id = params.fetch("id").to_i
  @patron = Patron.find(patron_id)
  book_ids = params.fetch("book_ids", [])
  @patron.update({:book_ids => book_ids})
  @checkouts = Checkout.find_by_patron(patron_id)
  @books = Book.all()
  erb(:patron_info)
end
