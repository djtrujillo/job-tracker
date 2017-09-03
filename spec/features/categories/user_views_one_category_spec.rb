require 'rails_helper'

describe "User visits one category page" do
  scenario "they see jobs for category" do
    category = Category.create(title: "Web Development")
    company = Company.create!(name: "ESPN")
    company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver", category_id: category.id)
    company.jobs.create(title: "Coder", level_of_interest: 99, city: "Amsterdam", category_id: category.id)

    visit category_path(category)

    expect(current_path).to eq("/categories/#{category.id}")
    expect(page).to have_content("Developer")
    expect(page).to have_content("Coder")
  end
end
