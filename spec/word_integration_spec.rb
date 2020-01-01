require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create a word path', {:type => :feature}) do
  it('creates a word and then goes to the word page') do
    visit('/words')
    save_and_open_page
    click_on('Add a New word')
    fill_in('word_name', :with => 'Yellow word')
    click_on('activate')
    expect(page).to have_content('Yellow word')
  end
end

describe('create a definition path', {:type => :feature}) do
  it('creates a word and then goes to the word page') do
    word = Word.new("Apple", "a red fruit")
    word.save
    visit("/words/#{word.id}")
    save_and_open_page
    fill_in('definition_post', :with => 'A red fruit')
    click_on('Add definition')
    expect(page).to have_content('A red fruit')
  end
end
