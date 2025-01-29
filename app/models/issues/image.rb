# == Schema Information
#
# Table name: issues_images
#
#  id         :bigint           not null, primary key
#  original   :string
#  path       :string
#  position   :integer
#  thumbnail  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  issue_id   :bigint           not null
#
class Issues::Image < ApplicationRecord
  belongs_to :issue
end
