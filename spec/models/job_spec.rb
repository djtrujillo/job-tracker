require 'rails_helper'

describe Job do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80, description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer", description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 80)
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, level of interest, and company" do
        company = Company.new(name: "Turing")
        category = Category.create(title: "Web Development")
        job = Job.new(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: category.id)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:company)
    end
  end

  describe "methods" do
    it "it can sort jobs by city" do
      company = Company.new(name: "Turing")
      category = Category.create(title: "Web Development")
      job  = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: category.id)
      job1 = Job.create(title: "Something else", level_of_interest: 30, city: "Denver", company: company, category_id: category.id)
      job2 = Job.create(title: "Something else # 3", level_of_interest: 20, city: "Zanzibar", company: company, category_id: category.id)
      job3 = Job.create(title: "Something else # 4", level_of_interest: 20, city: "New York", company: company, category_id: category.id)

      expect(Job.sort_by("location")).to eq([job, job1, job3, job2])
    end

    it "can return jobs by location" do
      company = Company.new(name: "Turing")
      category = Category.create(title: "Web Development")
      job  = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: category.id)
      job1 = Job.create(title: "Something else", level_of_interest: 30, city: "Denver", company: company, category_id: category.id)
      job2 = Job.create(title: "Something else # 3", level_of_interest: 20, city: "Zanzibar", company: company, category_id: category.id)
      job3 = Job.create(title: "Something else # 4", level_of_interest: 20, city: "New York", company: company, category_id: category.id)

      expect(Job.jobs_by_location("Denver")).to eq([job, job1])
    end

    it "can count jobs by interest" do
      company = Company.new(name: "Turing")
      category = Category.create(title: "Web Development")
      job  = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: category.id)
      job1 = Job.create(title: "Something else", level_of_interest: 30, city: "Denver", company: company, category_id: category.id)
      job2 = Job.create(title: "Something else # 3", level_of_interest: 20, city: "Zanzibar", company: company, category_id: category.id)
      job3 = Job.create(title: "Something else # 4", level_of_interest: 20, city: "New York", company: company, category_id: category.id)

      expect(Job.count_by_interest).to eq({20=>2, 30=>1, 40=>1})
    end

    it "returns top three companies by average level of interest" do
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

      expect(Job.top_companies).to eq([[company5.name, 55], [company4.name, 45], [company3.name, 35]])
    end

    it "it can sort jobs by interest" do
      company = Company.new(name: "Turing")
      category = Category.create(title: "Web Development")
      job  = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: category.id)
      job1 = Job.create(title: "Something else", level_of_interest: 30, city: "Denver", company: company, category_id: category.id)
      job2 = Job.create(title: "Something else # 3", level_of_interest: 20, city: "Zanzibar", company: company, category_id: category.id)
      job3 = Job.create(title: "Something else # 4", level_of_interest: 10, city: "New York", company: company, category_id: category.id)

      expect(Job.sort_by("interest")).to eq([job3, job2, job1, job])
    end

    it "can count jobs by location" do
      company = Company.new(name: "Turing")
      category = Category.create(title: "Web Development")
      job  = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: category.id)
      job1 = Job.create(title: "Something else", level_of_interest: 30, city: "Denver", company: company, category_id: category.id)
      job2 = Job.create(title: "Something else # 3", level_of_interest: 20, city: "Zanzibar", company: company, category_id: category.id)
      job3 = Job.create(title: "Something else # 4", level_of_interest: 10, city: "New York", company: company, category_id: category.id)

      expect(Job.count_by_location).to eq({"Denver"=>2, "Zanzibar"=>1, "New York"=>1})
    end

  end

end
