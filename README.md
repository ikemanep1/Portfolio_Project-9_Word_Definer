# _Ike's word definer!_

### _A place to learn words!_

### By _**Ike Esquivel-Pilloud**_

# Description

_This application is a database for words and their definitions. People can create, read, update, and delete words, as well as definitions for those words._

### Setup/Installation Requirements

* _1: download this application from github_
* _2: navigate to the file through the terminal_
* _3: type 'gem install' and 'bundle' into the console_
* _4: type 'ruby app.rb' into the console and navigate to 'localhost:4567' in your browser_

### Heroku location

https://enigmatic-savannah-93297.herokuapp.com

# Known Bugs

_The link provided will display an error that I as of yet cannot resolve._

# specs
| Behavior        | Input           | Outcome  |
| ------------- |:-------------:| -----:|
| The program will store a given word within its database. | "apple" | "apple" |
| The program will store given definitions for words stored in its database. | apple: "a red fruit" | apple: "a red fruit" |
| The program will delete/update words when commanded to do so. | "Delete!" | "there are no words to display" |
| The program will delete/update definitions for words stored in its database when commanded to do so. | "Update!" | "a tasty fruit" |

### Support and contact details

_ike.esquivelpilloud@gmail.com_

### Technologies Used

_the program as written in ruby, using atom, and tested with rspec and capybara. Sinatra was used as a visual guide in the development of this project._

### Gems used:

-'pry'
-'rspec'
-'sinatra'
-'capybara'
-'sinatra-contrib'


# License

_MIT licensing_

Copyright (c) 2019 **_Ike Esquivel-Pilloud_**



class Definition
  attr_reader :id
  attr_accessor :name, :word_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @word_id = attributes.fetch(:word_id)
    @id = attributes.fetch(:id)
  end

  def ==(definition_to_compare)
  if definition_to_compare != nil
    (self.name() == definition_to_compare.name()) && (self.word_id() == definition_to_compare.word_id())
  else
    false
  end
end

def self.all
    returned_definitions = DB.exec("SELECT * FROM definitions;")
    definitions = []
    returned_definitions.each() do |definition|
      name = definition.fetch("name")
      word_id = definition.fetch("word_id").to_i
      id = definition.fetch("id").to_i
      definitions.push(Definition.new({:name => name, :word_id => word_id, :id => id}))
    end
    definitions
  end

  def save
    result = DB.exec("INSERT INTO definitions (name, word_id) VALUES ('#{@name}', #{@word_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    definition = DB.exec("SELECT * FROM definitions WHERE id = #{id};").first
    if definition
      name = definition.fetch("name")
      word_id = definition.fetch("word_id").to_i
      id = definition.fetch("id").to_i
      Definition.new({:name => name, :word_id => word_id, :id => id})
    else
      nil
    end
  end

  def update(name, word_id)
    @name = name
    @word_id = word_id
    DB.exec("UPDATE definitions SET name = '#{@name}', word_id = #{@word_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM definitions WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM definitions *;")
  end

  def self.find_by_word(wor_id)
    definitions = []
    returned_definitions = DB.exec("SELECT * FROM definitions WHERE word_id = #{wor_id};")
    returned_definitions.each() do |definition|
      name = definition.fetch("name")
      id = definition.fetch("id").to_i
      definitions.push(Song.new({:name => name, :word_id => wor_id, :id => id}))
    end
    definitions
  end

  def words
    Word.find(self.word_id)
  end
end



class Word
  attr_reader :name, :id

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
  DB.exec("DELETE FROM definitions WHERE word_id = #{@id};")
  end

  def definitions
   Definition.find_by_word(self.id)
 end
end
