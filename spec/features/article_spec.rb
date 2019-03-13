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
