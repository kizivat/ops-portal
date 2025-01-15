# == Schema Information
#
# Table name: mestske_casti
#
#  id      :integer          unsigned, not null, primary key
#  alias   :string(64)       not null
#  genitiv :string(64)
#  logo    :string(255)
#  lokal   :string(64)
#  mesto   :integer          unsigned
#  nazov   :string(64)       not null
#  popis   :text(16777215)
#
module Legacy
  class MunicipalityDistrict < ApplicationRecord
    self.table_name = "mestske_casti"
  end
end
