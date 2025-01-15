# == Schema Information
#
# Table name: zodpovednost_kategorie
#
#  id              :integer          unsigned, not null, primary key
#  id_kategoria    :integer          unsigned, not null
#  id_zodpovednost :integer          unsigned, not null
#
module Legacy
  class ResponsibleSubjectCategory < ApplicationRecord
    self.table_name = "zodpovednost_kategorie"
  end
end
