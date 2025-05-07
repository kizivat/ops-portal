# == Schema Information
#
# Table name: municipality_districts
#
#  id              :bigint           not null, primary key
#  aliases         :string           default([]), not null, is an Array
#  description     :string
#  genitiv         :string
#  logo            :string
#  lokal           :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  legacy_id       :integer
#  municipality_id :bigint           not null
#
class MunicipalityDistrict < ApplicationRecord
  belongs_to :municipality

  def self.find_municipality_district(draft)
    result = MunicipalityDistrict.joins(:municipality)
      .where("municipalities.active = true")
      .where("? = ANY(municipalities.aliases)", draft.address_city)
      .where("? = ANY(municipality_districts.aliases)", draft.address_municipality)
      .first

    return result if result

    MunicipalityDistrict.joins(:municipality)
      .where("municipalities.active = true")
      .where("? = ANY(municipalities.aliases)", draft.address_municipality)
      .where("? = ANY(municipality_districts.aliases)", draft.address_suburb)
      .first
  end
end
