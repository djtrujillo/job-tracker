require 'rails_helper'

RSpec.feature "User deletes an existing job" do
  scenario "a user can delete a job" do
    category = Category.create(title: "Web Development")
    company = Company.create(name: "ESPN")
    job = company.jobs.create(title: "Programmer", description: "develop", city: "Denver", level_of_interest: 3, category_id: category.id)
    visit company_job_path(company,job)

    click_link "Delete"

    expect(current_path).to eq(company_jobs_path(company))
    expect(page).to_not have_content("Denver")
    expect(page).to_not have_content("develop")
  end
end
