require 'rspec'
require 'definition'
require 'word'
require 'pry'

describe '#Definition' do
  before(:each) do
    Word.clear()
    Definition.clear()
    @word = Word.new("apple", nil)
    @word.save()
  end

  describe('#==') do
    it("checks if two definitions in the database share attributes") do
      definition = Definition.new("noun: a red fruit", @word.id, nil)
      definition2 = Definition.new("noun: a red fruit", @word.id, nil)
      expect(definition).to(eq(definition2))
    end
  end

  describe('.all') do
    it("returns a list of all definitions for a word in the database") do
    definition = Definition.new("Apple, noun: a red fruit", @word.id, nil)
    definition.save()
    definition2 = Definition.new("Apple, noun: a member of the portland nobility", @word.id, nil)
    definition2.save()
    expect(Definition.all).to(eq([definition, definition2]))
  end
end

describe('.clear') do
    it("clears all definitions from a word in the database") do
      definition = Definition.new("apple, noun: a red fruit", @word.id, nil)
      definition.save()
      definition2 = Definition.new("apple, noun: a member of the portland nobility", @word.id, nil)
      definition2.save()
      Definition.clear()
      expect(Definition.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a definition to a word in the database") do
      definition = Definition.new("noun: a red fruit", @word.id, nil)
      definition.save()
      expect(Definition.all).to(eq([definition]))
    end
  end

  describe('.find') do
    it("finds a definition by id") do
      definition = Definition.new("apple, noun: a red fruit", @word.id, nil)
      definition.save()
      definition2 = Definition.new("apple, adjective: a person with particular talents in app development; he was willing and apple", @word.id, nil)
      definition2.save()
      expect(Definition.find(definition.id)).to(eq(definition))
    end
  end

  describe('#update') do
  it("updates a word in the database by id") do
    word = Word.new("apple", nil)
    word.save()
    word.update("economy")
    expect(word.name).to(eq("economy"))
  end
end
describe('#delete') do
    it("deletes a definition in the database by its word id") do
      definition = Definition.new("noun: a drunk bison", @word.id, nil)
      definition.save()
      definition2 = Definition.new("noun: a carnivorous tree", @word.id, nil)
      definition2.save()
      definition.delete()
      expect(Definition.all).to(eq([definition2]))
    end
  end
end
