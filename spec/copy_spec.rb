require('spec_helper')

describe(Copy) do

  describe('#copy') do
    it('returns the copy') do
      copy = Copy.new({:copy => "George Clooney", :id => nil})
      expect(copy.copy()).to(eq("George Clooney"))
    end
  end

  describe('#id') do
    it('returns the id') do
      copy = Copy.new({:copy => 1, :id => 1})
      expect(copy.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off with no copies") do
      expect(Copy.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a copy by its id number") do
      test_copy = Copy.new({:copy => "Brad Pitt", :id => nil})
      test_copy.save()
      test_copy2 = Copy.new({:copy => "george Clooney", :id => nil})
      test_copy2.save()
      expect(Copy.find(test_copy2.id())).to(eq(test_copy2))
    end
  end

  describe("#==") do
    it("is the same copy if it has the same copy and id") do
      copy = Copy.new({:copy => "George Clooney", :id => nil})
      copy2 = Copy.new(:copy => "George Clooney", :id => nil)
      expect(copy).to(eq(copy2))
    end
  end

  # describe("#update") do
  #   it("lets you update the copies in the database") do
  #     copy = Copy.new({:copy => "George Clooney", :id => nil})
  #     copy.save()
  #     copy.update({:copy => "Brad Pitt"})
  #     expect(copy.copy()).to(eq("Brad Pitt"))
  #   end

  #   it("lets you add a patron to an copy") do
  #     patron = Patron.new({:name => "Oceans Eleven", :id => nil})
  #     patron.save()
  #     copy = Copy.new({:copy => "George Clooney", :id => nil })
  #     copy.save()
  #     copy.update({:patron_ids => [patron.id()]})
  #     expect(copy.patrons()).to(eq([patron]))
  #   end
  # end

  # describe("#patrons") do
  #   it("returns all of the patrons a particular copy has written") do
  #     patron = Patron.new({:name => "Oceans Eleven", :id => nil})
  #     patron.save()
  #     patron2 = Patron.new({:name => "Oceans Twelve", :id => nil})
  #     patron2.save()
  #     copy = Copy.new({:copy => "George Clooney", :id => nil})
  #     copy.save()
  #     copy.update({:patron_ids => [patron.id()]})
  #     copy.update({:patron_ids => [patron2.id()]})
  #     expect(copy.patrons()).to(eq([patron, patron2]))
  #   end
  # end


  # describe('#delete') do
  #   it("lets you delete a copy from the database") do
  #     copy = Copy.new({:copy => 1, :id => nil})
  #     copy.save().to_i()
  #     copy2 = Copy.new({:copy => 2, :id => nil})
  #     copy2.save().to_i()
  #     copy.delete()
  #     expect(Copy.all()).to(eq([copy2]))
  #   end
  # end
end
