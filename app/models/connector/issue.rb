# == Schema Information
#
# Table name: connector_issues
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  backoffice_external_id :integer
#  triage_external_id     :integer
#
class Connector::Issue < ApplicationRecord
end
