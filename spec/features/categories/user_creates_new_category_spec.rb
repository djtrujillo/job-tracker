require 'rails_helper'

describe "User creates a new category" do
  scenario "a user can create a new category" do
    visit new_category_path

    fill_in "category[title]", with: "Web Development"
    click_button "Create"

    expect(current_path).to eq("/categories/#{Category.last.id}")
    expect(page).to have_content("Web Development")
    expect(Category.count).to eq(1)
  end
end

describe "User is not able to make duplicate category" do
  scenario "a user creates a category that already exists" do
    category = Category.create(title: "Web Development")

    visit new_category_path

    fill_in "category[title]", with: "Web Development"
    click_button "Create"

    expect(current_path).to eq(new_category_path)
    expect(Category.count).to eq(1)
  end
end
