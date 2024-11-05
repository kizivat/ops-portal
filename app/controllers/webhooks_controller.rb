class WebhooksController < ActionController::API
  before_action :set_issue, only: %i[ ticket_updated ]

  def ticket_updated
    @issue.state = ticket_params[:state]

    render :new, status: :unprocessable_entity unless @issue.save
  end

  private

  def set_issue
    @issue = Issue.find_by(zammad_id: ticket_params[:id])
  end

  def ticket_params
    params.expect(ticket: [ :id, :state ])
  end
end
