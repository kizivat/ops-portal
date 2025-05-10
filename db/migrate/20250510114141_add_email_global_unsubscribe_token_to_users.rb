class AddEmailGlobalUnsubscribeTokenToUsers < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :email_global_unsubscribe_token, :string
    add_index :users, :email_global_unsubscribe_token, unique: true

    User.reset_column_information
    User.find_each do |user|
      loop do
        user.email_global_unsubscribe_token = SecureRandom.urlsafe_base64(32)
        break unless User.exists?(email_global_unsubscribe_token: user.email_global_unsubscribe_token)
      end
      user.save!(validate: false)
    end

    change_column_null :users, :email_global_unsubscribe_token, false
  end

  def down
    remove_index :users, :email_global_unsubscribe_token
    remove_column :users, :email_global_unsubscribe_token
  end
end
