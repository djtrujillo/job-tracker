require 'rails_helper'

RSpec.feature "User edits an existing job" do
  scenario "a user can edit a job" do
    company = Company.create(name: "ESPN")
    job = company.jobs.create(title: "Programmer", description: "develop", city: "Denver", level_of_interest: 3)

    visit edit_company_job_path(company, job)

    fill_in "job[city]", with: "San Francisco"
    fill_in "job[description]", with: "Testing"

    click_button "Update"

    expect(page).to have_content("San Francisco")
    expect(page).to_not have_content("Denver")
    expect(page).to have_content("Testing")
    expect(page).to_not have_content("develop")
  end
end
