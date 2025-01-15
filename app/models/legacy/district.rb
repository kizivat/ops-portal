# == Schema Information
#
# Table name: kraje
#
#  id          :integer          unsigned, not null, primary key
#  nazov_kraju :string(64)
#
module Legacy
  class District < ApplicationRecord
    self.table_name = "kraje"
  end
end
