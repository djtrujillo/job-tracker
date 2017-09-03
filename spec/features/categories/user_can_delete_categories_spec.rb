require 'rails_helper'

describe "User deletes existing category" do
  scenario "a user deletes a category" do
    category1 = Category.create(title: "Web Development")
    category2 = Category.create(title: "DevOps")
    visit categories_path

    within(".category_#{category1.id}") do
      click_link "Delete"
    end

    expect(page).to_not have_content("Web Development")
    expect(page).to have_content("DevOps")
  end
end
