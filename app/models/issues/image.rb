# == Schema Information
#
# Table name: issues_images
#
#  id          :bigint           not null, primary key
#  object_type :string
#  original    :string
#  path        :string
#  position    :integer
#  thumbnail   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  object_id   :bigint
#
class Issues::Image < ApplicationRecord
end
