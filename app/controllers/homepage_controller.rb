class HomepageController < ApplicationController
  def show
    @issues = Issue.order(reported_at: :desc).limit(4) # TODO show relevant on home page
    @news = [] # TODO
  end
end
