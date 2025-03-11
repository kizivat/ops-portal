# == Schema Information
#
# Table name: connector_users
#
#  id                               :bigint           not null, primary key
#  firstname                        :string
#  lastname                         :string
#  uuid                             :uuid
#  zammad_identifier                :integer
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  connector_backoffice_instance_id :bigint
#
class Connector::User < ApplicationRecord
  belongs_to :backoffice_instance, class_name: "Connector::BackofficeInstance", optional: false, foreign_key: :connector_backoffice_instance_id
end
