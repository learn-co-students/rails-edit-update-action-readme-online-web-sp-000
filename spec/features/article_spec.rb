require 'rails_helper'

describe 'navigate' do
  before do
    @article = Article.create(title: "My Article", description: "My article desc")
  end

  it 'shows the title on the show page in a h1 tag' do
    visit "/articles/#{@article.id}"
    expect(page).to have_css("h1", text: "My Article")
  end

  it 'to article pages' do
    visit "/articles/#{@article.id}"
    expect(page.status_code).to eq(200)
  end

  it 'shows the description on the show page in a p tag' do
    visit "/articles/#{@article.id}"
    expect(page).to have_css("p", text: "My article desc")
  end
end

describe 'form' do
  it 'shows a new form that submits content and redirects and prints out params' do
    visit new_article_path

    fill_in 'title', with: "My article title"
    fill_in 'description', with: "My article description"

    click_on "Submit Article"

    expect(page).to have_content("My article title")
  end

  it 'shows an edit form that submits content and redirects and prints out params' do
    @article = Article.create(title: "My Article", description: "My article desc")

    visit edit_article_path(@article)

    fill_in 'article[title]', with: "My edit"
    fill_in 'article[description]', with: "My article description"

    click_on "Submit Article"

    expect(page).to have_content("My edit")
  end
end
