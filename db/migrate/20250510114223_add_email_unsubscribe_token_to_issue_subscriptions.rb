class AddEmailUnsubscribeTokenToIssueSubscriptions < ActiveRecord::Migration[8.0]
  def up
    add_column :issue_subscriptions, :email_unsubscribe_token, :string
    add_index :issue_subscriptions, :email_unsubscribe_token, unique: true

    IssueSubscription.reset_column_information
    IssueSubscription.find_each do |subscription|
      subscription.update_attribute!(:email_unsubscribe_token, "#{subscription.id}" + SecureRandom.urlsafe_base64(32))
    end

    change_column_null :issue_subscriptions, :email_unsubscribe_token, false
  end

  def down
    remove_index :issue_subscriptions, :email_unsubscribe_token
    remove_column :issue_subscriptions, :email_unsubscribe_token
  end
end
