# == Schema Information
#
# Table name: issues_comment_images
#
#  id         :bigint           not null, primary key
#  path       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment_id :bigint           not null
#
class Issues::CommentImage < ApplicationRecord
  belongs_to :comment
end
