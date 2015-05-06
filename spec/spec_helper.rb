require('rspec')
require('pg')
require('author')
require('book')

DB = PG.connect({:dbname => 'library_database_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM books *;")
  end
end
