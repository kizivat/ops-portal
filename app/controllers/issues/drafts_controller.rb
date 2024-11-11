class Issues::DraftsController < ApplicationController
  def new
    @draft = Issues::Draft.new
  end

  def create
    @draft = Issues::Draft.new(draft_params)
    if @draft.save(context: :photos_step)
      redirect_to issues_draft_suggestions_path(@draft)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @draft = Issues::Draft.find(params[:id])
  end

  private

  def draft_params
    params.expect(issues_draft: [ photos: [] ])
  end
end
