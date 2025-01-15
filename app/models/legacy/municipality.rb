# == Schema Information
#
# Table name: mesta
#
#  id               :integer          unsigned, not null, primary key
#  alias            :string(64)       not null
#  city_type        :integer          default(2), not null
#  created_date     :date
#  email            :string(64)       default("podnet"), not null
#  kraj             :integer          unsigned
#  languages        :text(16777215)
#  logo             :string(255)
#  map_x            :string(25)
#  map_y            :string(25)
#  mestske_casti    :integer          default(1), not null
#  nazov            :string(64)       not null
#  pocet_obyvatelov :integer          unsigned
#  spravuje         :integer          unsigned, not null
#  status           :integer          default(0), unsigned, not null
#  sub              :string(16)
#  typ              :integer          default(1), unsigned, not null
#
module Legacy
  class Municipality < ApplicationRecord
    self.table_name = "mesta"
  end
end
