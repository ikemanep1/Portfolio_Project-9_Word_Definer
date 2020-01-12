require 'rspec'
require 'word'
require 'definition'
require 'pry'
require "spec_helper"

describe '#Word' do

  describe '#Word' do

    describe('.all') do
      it("returns an empty array when there are no words") do
        expect(Word.all).to(eq([]))
      end
    end

    describe('#save') do
      it("saves an word") do
        word = Word.new({:name => "A Love Supreme", :id => nil})
        word.save()
        word2 = Word.new({:name => "Blue", :id => nil})
        word2.save()
        expect(Word.all).to(eq([word, word2]))
      end
    end

    describe('.clear') do
      it("clears all words") do
        word = Word.new({:name => "A Love Supreme", :id => nil})
        word.save()
        word2 = Word.new({:name => "Blue", :id => nil})
        word2.save()
        Word.clear
        expect(Word.all).to(eq([]))
      end
    end

    describe('#==') do
      it("is the same word if it has the same attributes as another word") do
        word = Word.new({:name => "Blue", :id => nil})
        word2 = Word.new({:name => "Blue", :id => nil})
        expect(word).to(eq(word2))
      end
    end

    describe('.find') do
      it("finds an word by id") do
        word = Word.new({:name => "A Love Supreme", :id => nil})
        word.save()
        word2 = Word.new({:name => "Blue", :id => nil})
        word2.save()
        expect(Word.find(word.id)).to(eq(word))
      end
    end

    describe('#update') do
      it("updates an word by id") do
        word = Word.new({:name => "A Love Supreme", :id => nil})
        word.save()
        word.update("A Love Supreme")
        expect(word.name).to(eq("A Love Supreme"))
      end
    end

    describe('#delete') do
      it("deletes all definitions belonging to a deleted word") do
        word = Word.new({:name => "A Love Supreme", :id => nil})
        word.save()
        definition = Definition.new({:name => "Naima", :word_id => word.id, :id => nil})
        definition.save()
        word.delete()
        expect(Definition.find(definition.id)).to(eq(nil))
      end
    end

    describe('#definitions') do
      it("returns an word's definitions") do
        word = Word.new({:name => "A Love Supreme", :id => nil})
        word.save()
        definition = Definition.new({:name => "Naima", :word_id => word.id, :id => nil})
        definition.save()
        definition2 = Definition.new({:name => "Cousin Mary", :word_id => word.id, :id => nil})
        definition2.save()
        expect(word.definitions).to(eq([definition, definition2]))
      end
    end
  end
end
