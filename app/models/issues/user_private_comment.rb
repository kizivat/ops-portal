# == Schema Information
#
# Table name: issues_comments
#
#  id                            :bigint           not null, primary key
#  added_at                      :datetime
#  author_email                  :string
#  author_name                   :string
#  embed                         :string
#  hidden                        :boolean          default(FALSE)
#  image                         :string
#  ip                            :inet
#  link                          :string
#  published                     :boolean
#  state                         :boolean
#  text                          :string
#  verification                  :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  activity_id                   :bigint           not null
#  agent_author_id               :bigint
#  legacy_id                     :integer
#  responsible_subject_author_id :bigint
#  triage_external_id            :integer
#  user_author_id                :bigint
#
class Issues::UserPrivateComment < Issues::Comment
  def author
    user_author
  end
end
