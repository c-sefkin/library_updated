require("spec_helper")

describe(Patron) do

  describe('#name') do
    it("returns the name") do
      patron = Patron.new({:name => "Oceans Eleven", :id => nil})
      expect(patron.name()).to(eq("Oceans Eleven"))
    end
  end

  describe('#id') do
    it('returns the id') do
      patron = Patron.new({:name => "Oceans Eleven", :id => 1})
      expect(patron.id()).to(eq(1))
    end
  end


  describe('.all') do
    it('starts off with no patrons') do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('.find') do
    it('returns a patron by its id number') do
      test_patron = Patron.new({:name => "Oceans Eleven", :id => nil})
      test_patron.save()
      test_patron2 = Patron.new({:name => "George Clloney", :id => nil})
      test_patron2.save()
      expect(Patron.find(test_patron2.id())).to(eq(test_patron2))
    end
  end

  describe('#==') do
    it('is the same patron if it has the same name and id') do
      patron = Patron.new({:name => "Oceans Eleven", :id => nil})
      patron2 = Patron.new({:name => "Oceans Eleven", :id => nil})
      expect(patron).to(eq(patron2))
    end
  end

  # describe('#update') do
  #   it("lets you update patrons in the database") do
  #     patron = Patron.new({:name => "George Clooney", :id => nil})
  #     patron.save()
  #     patron.update({:name => "Brad Pitt", :id => nil})
  #     expect(patron.name()).to(eq("Brad Pitt"))
  #   end

  #   it("lets you add an copy to a patron") do
  #     patron = Patron.new({:name => "Oceans Eleven", :id => nil})
  #     patron.save()
  #     george = Copy.new({:copy => "George Clooney", :id => nil})
  #     george.save()
  #     brad = Copy.new({:copy => "Brad Pitt", :id => nil})
  #     brad.save()
  #     patron.update({:copy_ids => [george.id(), brad.id()]})
  #     expect(patron.copies()).to(eq([george, brad]))
  #   end
  # end

  describe('#delete') do
    it("lets you delete a patron from the database") do
      patron = Patron.new({:name => "George Clooney", :id => nil})
      patron.save()
      patron2 = Patron.new({:name => "Brad Pitt", :id => nil})
      patron2.save()
      patron.delete()
      expect(Patron.all()).to(eq([patron2]))
    end
  end

  # describe('#copies') do
  #   it("returns all of the copies for this patron") do
  #     patron = Patron.new({:name => "Oceans Eleven", :id => nil})
  #     patron.save()
  #     george = Copy.new({:copy => "George Clooney", :id => nil})
  #     george.save()
  #     brad = Copy.new({:copy => "Brad Pitt", :id => nil})
  #     brad.save()
  #     # patron.update({:copy_ids => [george.id(), brad.id()]})
  #     expect(patron.copies()).to(eq([george, brad]))
  #   end
  # end
end
