require 'rails_helper'

describe "User edits an existing category" do
  scenario "a user edits a category" do
    category = Category.create(title: "Web Development")
    visit edit_category_path(category)

    fill_in "category[title]", with: "Something Else"
    click_button "Update"

    expect(current_path).to eq("/categories/#{Category.last.id}")
    expect(page).to have_content("Something Else")
    expect(page).to_not have_content("Web Development")
  end
end
