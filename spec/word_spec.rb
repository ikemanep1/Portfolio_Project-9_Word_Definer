require 'rspec'
require 'word'
require 'pry'

describe '#Word' do
  before(:each) do
    Word.clear()
  end

  describe('.clear') do
    it("empties all words from the database") do
      word = Word.new("apple", nil)
      word.save()
      Word.clear()
      expect(Word.all).to(eq([]))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no words") do
      expect(Word.all).to(eq([]))
    end
  end

  describe('#save') do
    it("adds a new word to the database") do
      word = Word.new("apple", nil)
      word.save()
      expect(Word.all).to(eq([word]))
    end
  end

  describe('#==') do
    it("checks if two words share attributes") do
      word = Word.new("elephant", nil)
      word2 = Word.new("elephant", nil)
      expect(word).to(eq(word2))
    end
  end

  describe('.find') do
    it("fetches a word in the database by its id") do
      word = Word.new("apple", nil)
      word.save()
      word2 = Word.new("entropy", nil)
      word2.save()
      expect(Word.find(word.id)).to(eq(word))
    end
  end

  describe('#update') do
    it('updates a word in the database by its id') do
    word = Word.new("apple", nil)
    word.save()
    word.update("orange")
    expect(word.name).to(eq("orange"))
  end
end

  describe('#delete') do
    it("deletes a word from the database, using its id") do
      word = Word.new("apple", nil)
      word.save()
      word2 = Word.new("entropy", nil)
      word2.save()
      word3 = Word.new("fulcrum", nil)
      word3.save()
      word.delete()
      expect(Word.all).to(eq([word2, word3]))
    end
  end
end
