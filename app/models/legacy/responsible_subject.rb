# == Schema Information
#
# Table name: zodpovednost
#
#  id           :integer          unsigned, not null, primary key
#  code         :string(64)
#  email        :string(255)      not null
#  kategoria    :integer          default(0), not null
#  kraj         :integer
#  meno         :string(255)      not null
#  mesto        :integer
#  mestska_cast :integer
#  nazov        :string(255)      not null
#  pro          :boolean          default(FALSE), not null
#  scope        :integer
#  status       :integer          unsigned, not null
#  typ          :integer          unsigned, not null
#
module Legacy
  class ResponsibleSubject < ApplicationRecord
    self.table_name = "zodpovednost"
  end
end
