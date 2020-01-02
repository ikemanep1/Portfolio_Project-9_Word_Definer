require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create a word path', {:type => :feature}) do
  it('creates a word and then goes to the word page') do
    visit('/words')
    save_and_open_page
    click_on('Create a New Word!')
    fill_in('word_name', :with => 'Yellow word')
    click_on('Create word!')
    expect(page).to have_content('Yellow word')
  end
end

describe('create a definition path', {:type => :feature}) do
  it('creates a word and then goes to the word page') do
    word = Word.new("Apple", nil)
    word.save
    visit("/words/#{word.id}")
    save_and_open_page
    fill_in('definition_name', :with => 'A red fruit')
    click_on('Add Definition')
    expect(page).to have_content('A red fruit')
  end
end
