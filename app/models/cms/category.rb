# == Schema Information
#
# Table name: cms_categories
#
#  id                 :bigint           not null, primary key
#  name               :string           not null
#  raw                :jsonb            not null
#  slug               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  parent_category_id :bigint
#
class Cms::Category < ApplicationRecord
  belongs_to :parent_category, class_name: "Cms::Category", optional: true

  has_many :categories, class_name: "Cms::Category"
  has_many :pages, class_name: "Cms::Page"

  def self.root_cms
    find_by(slug: "cms") || raise(Exception.new("Missing required data: Cms::Category with `cms` slug."))
  end

  def to_param
    slug
  end
end
