# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  email             :string
#  firstname         :string
#  lastname          :string
#  uuid              :uuid             not null
#  zammad_identifier :integer
#
class User < ApplicationRecord
end
