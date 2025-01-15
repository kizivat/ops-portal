# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  about              :text(16777215)
#  access_token       :string(32)
#  admin_name         :string(64)
#  anonymous          :integer          default(0), unsigned, not null
#  birth              :date
#  cityid             :integer
#  created_from_app   :boolean          default(FALSE), not null
#  email              :string(64)       not null
#  email_notification :boolean          default(TRUE)
#  exp                :integer
#  fcm_token          :text(16777215)
#  gdpr_accepted      :boolean
#  is_banned          :boolean          default(FALSE), unsigned, not null
#  is_organization    :integer
#  login              :string(64)       not null
#  logo               :string(64)
#  meno               :string(32)
#  mesto              :integer          default(1), unsigned, not null
#  password           :string(60)       not null
#  priezvisko         :string(30)
#  residency          :integer
#  rights             :string(2)        not null
#  sex                :string
#  signature          :text(16777215)
#  status             :boolean          not null
#  streetid           :integer
#  telefon            :string(40)
#  timestamp          :bigint           not null
#  verification       :string(64)
#  verified           :boolean          default(FALSE), unsigned, not null
#  website            :string(64)
#
module Legacy
  class User < ApplicationRecord
  end
end
