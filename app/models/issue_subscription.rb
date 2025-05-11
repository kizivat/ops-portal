# == Schema Information
#
# Table name: issue_subscriptions
#
#  id                      :bigint           not null, primary key
#  email_unsubscribe_token :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  issue_id                :bigint           not null
#  subscriber_id           :bigint           not null
#
class IssueSubscription < ApplicationRecord
  belongs_to :issue
  belongs_to :subscriber, class_name: "User"

  before_create :set_email_unsubscribe_token
  validates :email_unsubscribe_token, uniqueness: true, allow_nil: false

  private

  def set_email_unsubscribe_token
    loop do
      self.email_unsubscribe_token = SecureRandom.hex(32)
      break unless IssueSubscription.exists?(email_unsubscribe_token: email_unsubscribe_token)
    end
  end
end
