require 'rails_helper'

describe "user views list of all jobs sorted by city" do
  scenario "user visits page with jobs sorted by city" do
    category1 = Category.create(title: "Web Development")
    category2 = Category.create(title: "Finacial Management")
    company = Company.create!(name: "ESPN")
    company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category1.id)
    company.jobs.create!(title: "Accoutant", level_of_interest: 90, city: "Denver", category_id: category2.id)
    company.jobs.create!(title: "QA Analyst", level_of_interest: 70, city: "New York City", category_id: category1.id)

    visit '/jobs?sort=location'

    expect(page).to have_content("Denver")
  end
end
