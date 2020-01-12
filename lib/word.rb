class Word
  attr_reader :id, :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
  returned_words = DB.exec("SELECT * FROM words;")
  words = []
  returned_words.each() do |word|
    name = word.fetch("name")
    id = word.fetch("id").to_i
    words.push(Word.new({:name => name, :id => id}))
  end
  words
end

def save
result = DB.exec("INSERT INTO words (name) VALUES ('#{@name}') RETURNING id;")
@id = result.first().fetch("id").to_i
end

  def ==(word_to_compare)
    self.name() == word_to_compare.name()
  end

  def self.clear
  DB.exec("DELETE FROM words *;")
end

def self.find(id)
word = DB.exec("SELECT * FROM words WHERE id = #{id};").first
name = word.fetch("name")
id = word.fetch("id").to_i
Word.new({:name => name, :id => id})
end

def update(name)
@name = name
DB.exec("UPDATE words SET name = '#{@name}' WHERE id = #{@id};")
end

def delete
  DB.exec("DELETE FROM words WHERE id = #{@id};")
  DB.exec("DELETE FROM definitions WHERE word_id = #{@id};") # new code
end

  def definitions
    Definition.find_by_word(self.id)
  end
end
