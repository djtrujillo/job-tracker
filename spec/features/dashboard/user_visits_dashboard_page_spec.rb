require 'rails_helper'

describe "user visits dashboard page" do
  scenario "user views count of jobs by level of interest" do
    category1 = Category.create(title: "Web Development")
    category2 = Category.create(title: "Finacial Management")
    company = Company.create!(name: "ESPN")
    company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category1.id)
    company.jobs.create!(title: "Accoutant", level_of_interest: 90, city: "Denver", category_id: category2.id)
    company.jobs.create!(title: "QA Analyst", level_of_interest: 70, city: "New York City", category_id: category1.id)

    visit '/dashboard'

    expect(page).to have_content("Level of Interest: 70 Count: 2 Level of Interest: 90 Count: 1")

  end

  scenario "user views top 3 companies ranked by avg lvl of interest with respective avg lvl interest" do
    category1 = Category.create(title: "Web Development")
    company1 = Company.create!(name: "Toodeloo")
    company2 = Company.create!(name: "Yahoo")
    company3 = Company.create!(name: "Google")
    company4 = Company.create!(name: "Turing")
    company5 = Company.create!(name: "Zen")
    company1.jobs.create!(title: "Developer", level_of_interest: 10, city: "Denver", category_id: category1.id)
    company1.jobs.create!(title: "Accoutant", level_of_interest: 20, city: "Denver", category_id: category1.id)
    company2.jobs.create!(title: "QA Analyst", level_of_interest: 20, city: "New York City", category_id: category1.id)
    company2.jobs.create!(title: "QA Analyst", level_of_interest: 30, city: "New York City", category_id: category1.id)
    company3.jobs.create!(title: "QA Analyst", level_of_interest: 30, city: "New York City", category_id: category1.id)
    company3.jobs.create!(title: "QA Analyst", level_of_interest: 40, city: "New York City", category_id: category1.id)
    company4.jobs.create!(title: "QA Analyst", level_of_interest: 40, city: "New York City", category_id: category1.id)
    company4.jobs.create!(title: "QA Analyst", level_of_interest: 50, city: "New York City", category_id: category1.id)
    company5.jobs.create!(title: "QA Analyst", level_of_interest: 50, city: "New York City", category_id: category1.id)
    company5.jobs.create!(title: "QA Analyst", level_of_interest: 60, city: "New York City", category_id: category1.id)

    visit '/dashboard'

    expect(page).to have_content("Top Three Companies by Average Level of Interest")
    expect(page).to have_content("Company: Zen, Average Level of Interest: 55")
    expect(page).to have_content("Company: Turing, Average Level of Interest: 45")
    expect(page).to have_content("Company: Google, Average Level of Interest: 35")

  end

  scenario "user views count of jobs by location with a link to visit Jobs Index" do
    company = Company.new(name: "Turing")
    category = Category.create(title: "Web Development")
    job  = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: category.id)
    job1 = Job.create(title: "Something else", level_of_interest: 30, city: "Denver", company: company, category_id: category.id)
    job2 = Job.create(title: "Something else # 3", level_of_interest: 20, city: "Zanzibar", company: company, category_id: category.id)
    job3 = Job.create(title: "Something else # 4", level_of_interest: 10, city: "Newark", company: company, category_id: category.id)

    visit dashboard_path

    expect(page).to have_content("Count of Jobs by Location")
    expect(page).to have_content("Location: Denver, Count of Jobs: 2")
    expect(page).to have_link("Denver", '/jobs?location=Denver')

    expect(page).to have_content("Location: Newark, Count of Jobs: 1")
    expect(page).to have_link("Newark", '/jobs?location=Newark')

    expect(page).to have_content("Location: Zanzibar, Count of Jobs: 1")
    expect(page).to have_link("Zanzibar", '/jobs?location=Zanzibar')
  end


end
