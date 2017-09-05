class DashboardsController < ApplicationController

  def show
    @jobs = Job.all
    @companies = Company.all
  end

end
