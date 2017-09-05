require 'rails_helper'

describe "user can create a contact" do
  scenario "they visit company page and fill in contact form" do
    category = Category.create(title: "Web Development")
    company = Company.create!(name: "ABC")

    visit company_path(company)

    # save_and_open_page

    fill_in "contact[name]", with: "Danny Trujillo"
    fill_in "contact[position]", with: "Kickin' Ass"
    fill_in "contact[email]", with: "danny.j.trujillo@gmail.com"
    click_button "Submit"

    expect(current_path).to eq("/companies/#{company.id}")
    expect(page).to have_content("Kickin' Ass")
    expect(page).to have_content("danny.j.trujillo@gmail.com")
  end
end
