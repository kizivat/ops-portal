# == Schema Information
#
# Table name: ulice
#
#  id           :integer          unsigned, not null, primary key
#  geo_x        :decimal(13, 10)
#  geo_y        :decimal(13, 10)
#  mesto        :integer          default(1), unsigned, not null
#  mestska_cast :integer          unsigned, not null
#  nazov        :string(50)       not null
#  tested       :integer          default(1), not null
#  place_id     :string(255)
#
module Legacy
  class Street < ApplicationRecord
    self.table_name = "ulice"
  end
end
