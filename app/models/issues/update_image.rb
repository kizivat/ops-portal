# == Schema Information
#
# Table name: issues_update_images
#
#  id         :bigint           not null, primary key
#  path       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  update_id  :bigint           not null
#
class Issues::UpdateImage < ApplicationRecord
  belongs_to :issue_update, class_name: 'Issues::Update', foreign_key: :update_id
end
