require('rspec')
require('pg')
require('author')
require('book')
require('patron')
require('copy')

DB = PG.connect({:dbname => 'library_database_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM copies *;")
    DB.exec("DELETE FROM checkout *;")
  end
end
