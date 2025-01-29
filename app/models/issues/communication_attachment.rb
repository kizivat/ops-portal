# == Schema Information
#
# Table name: issues_communication_attachments
#
#  id               :bigint           not null, primary key
#  extension        :string
#  image            :boolean
#  name             :string
#  path             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  communication_id :bigint           not null
#  issue_id         :bigint           not null
#
class Issues::CommunicationAttachment < ApplicationRecord
  belongs_to :communication
  belongs_to :issue
end
