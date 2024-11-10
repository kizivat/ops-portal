class Issues::Drafts::DetailsController < ApplicationController
  def new
    @draft = Issue::Draft.find(params[:draft_id])
  end
end
