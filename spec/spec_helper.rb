require 'rspec'
require 'pg'
require 'word'
require 'definition'
require 'pry'

DB = PG.connect({:dbname => 'word_finder_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM words *;")
    DB.exec("DELETE FROM definitions *;")
  end
end
