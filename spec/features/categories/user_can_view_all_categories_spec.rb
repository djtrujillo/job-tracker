require 'rails_helper'

describe "User sees all categories" do
  scenario "a user sees all the categories" do
    category1 = Category.create(title: "Web Development")
    category2 = Category.create(title: "DevOps")

    visit categories_path

    expect(page).to have_content("Web Development")
    expect(page).to have_content("DevOps")
  end
end
