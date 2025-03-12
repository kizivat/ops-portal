# == Schema Information
#
# Table name: connector_tenants
#
#  id             :bigint           not null, primary key
#  api_token      :string
#  url            :string
#  webhook_secret :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Connector::BackofficeInstance < ApplicationRecord
  has_many :tenants, class_name: "Connector::Tenant", inverse_of: :tenant, dependent: :destroy
  has_many :issues, class_name: "Connector::Issue", inverse_of: :tenant, dependent: :destroy
  has_many :comments, class_name: "Connector::Comment", inverse_of: :tenant, dependent: :destroy
  has_many :users, class_name: "Connector::User", inverse_of: :tenant, dependent: :destroy
end
