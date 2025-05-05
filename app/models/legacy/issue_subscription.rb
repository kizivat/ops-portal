# == Schema Information
#
# Table name: legacy_issue_subscriptions
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  issue_id      :bigint           not null
#  subscriber_id :bigint           not null
#
class Legacy::IssueSubscription < ApplicationRecord
  belongs_to :issue
  belongs_to :subscriber, class_name: "Legacy::Agent"
end
