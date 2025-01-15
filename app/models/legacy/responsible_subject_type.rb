# == Schema Information
#
# Table name: zodpovednost_typy
#
#  id     :integer          unsigned, not null, primary key
#  nazov  :string(255)      not null
#  status :integer          unsigned, not null
#
module Legacy
  class ResponsibleSubjectType < ApplicationRecord
    self.table_name = "zodpovednost_typy"
  end
end
