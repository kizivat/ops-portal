# == Schema Information
#
# Table name: alerts_categories
#
#  id              :integer          unsigned, not null, primary key
#  catch_all       :boolean
#  kategoria       :string(255)      not null
#  kategoria_alias :string(32)       not null
#  kategoria_hu    :string(255)      not null
#  parent          :integer
#  popis           :text(16777215)   not null
#  popis_hu        :text(16777215)   not null
#  weight          :integer          not null
#
module Legacy
  module Issue
    class Category < ApplicationRecord
      self.table_name = "alerts_categories"
    end
  end
end
