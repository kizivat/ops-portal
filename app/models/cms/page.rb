# == Schema Information
#
# Table name: cms_pages
#
#  id          :bigint           not null, primary key
#  raw         :jsonb            not null
#  slug        :string           not null
#  tags        :string           default([]), is an Array
#  text        :text             not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
class Cms::Page < ApplicationRecord
  belongs_to :category, class_name: "Cms::Category", required: true

  validates :title, :slug, :text, presence: true

  def self.with_tags(tags)
    if tags.present?
      where("tags @> ARRAY[?]::varchar[]", tags)
    else
      all
    end
  end

  def self.published
    with_tags([ "published" ])
  end

  def to_param
    slug
  end
end
