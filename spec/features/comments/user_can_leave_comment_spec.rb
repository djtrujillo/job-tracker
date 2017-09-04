require 'rails_helper'

describe "user creates a comment" do
  scenario "fills in comment on job show page" do
    category = Category.create(title: "Web Development")
    company = Company.create!(name: "ESPN")
    job = company.jobs.create!(title: "Developer", level_of_interest: 90, city: "Denver", category_id: category.id)

    visit company_job_path(company, job)

    fill_in "comment[body]", with: "This is a comment"
    click_button "Submit"

    expect(current_path).to eq("/companies/#{company.id}/jobs/#{job.id}")
    expect(page).to have_content("This is a comment")
    expect(Comment.count).to eq(1)
  end
end
