class Api::V1::ResponsibleSubjectsController < ApplicationController
  def search
    @responsible_subjects = ResponsibleSubject.search(params[:q]).limit(5)
  end
end
