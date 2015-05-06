require("spec_helper")

describe(Book) do

  describe('#name') do
  it("returns the name") do
    book = Book.new({:name => "Oceans Eleven", :id => nil})
    expect(book.name()).to(eq("Oceans Eleven"))
  end
end

  describe('#id') do
    it('returns the id') do
      book = Book.new({:name => "Oceans Eleven", :id => 1})
      expect(book.id()).to(eq(1))
    end
  end


  describe('.all') do
   it('starts off with no books') do
    expect(Book.all()).to(eq([]))
  end
 end

  describe('.find') do
    it('returns a book by its id number') do
      test_book = Book.new({:name => "Oceans Eleven", :id => nil})
      test_book.save()
      test_book2 = Book.new({:name => "George Clloney", :id => nil})
      test_book2.save()
      expect(Book.find(test_book2.id())).to(eq(test_book2))
    end
  end

  describe('#==') do
    it('is the same book if it has the same name and id') do
      book = Book.new({:name => "Oceans Eleven", :id => nil})
      book2 = Book.new({:name => "Oceans Eleven", :id => nil})
      expect(book).to(eq(book2))
    end
  end

  describe('#update') do
    it("lets you update books in the database") do
      book = Book.new({:name => "George Clooney", :id => nil})
      book.save()
      book.update({:name => "Brad Pitt", :id => nil})
      expect(book.name()).to(eq("Brad Pitt"))
    end
  end

  describe('#delete') do
    it("lets you delete a book from the database") do
      book = Book.new({:name => "George Clooney", :id => nil})
      book.save()
      book2 = Book.new({:name => "Brad Pitt", :id => nil})
      book2.save()
      book.delete()
      expect(Book.all()).to(eq([book2]))
    end
  end

end
