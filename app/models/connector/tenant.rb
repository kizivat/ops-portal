# == Schema Information
#
# Table name: connector_tenants
#
#  id                               :bigint           not null, primary key
#  api_subject_identifier           :integer
#  api_token_private_key            :string
#  name                             :string
#  webhook_public_key               :string
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  connector_backoffice_instance_id :bigint
#  triage_user_id                   :integer
#
class Connector::Tenant < ApplicationRecord
  belongs_to :backoffice_instance, class_name: "Connector::BackofficeInstance", optional: false, foreign_key: :connector_backoffice_instance_id
end
