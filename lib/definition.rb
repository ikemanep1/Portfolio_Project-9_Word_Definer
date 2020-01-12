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

  def self.find_by_word(alb_id)
    definitions = []
    returned_definitions = DB.exec("SELECT * FROM definitions WHERE word_id = #{alb_id};")
    returned_definitions.each() do |definition|
      name = definition.fetch("name")
      id = definition.fetch("id").to_i
      definitions.push(Definition.new({:name => name, :word_id => alb_id, :id => id}))
    end
    definitions
  end

  def word
    Word.find(@word_id)
  end
end
