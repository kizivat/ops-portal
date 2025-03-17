class CreateRodauth < ActiveRecord::Migration[8.0]
  def change
    enable_extension "citext"

    # Modify the existing users table
    reversible do |direction|
      direction.up   { change_column :users, :email, :citext, null: false }
      direction.down { change_column :users, :email, :string, null: true }
    end
    add_check_constraint :users, "email ~ '^[^,;@ \r\n]+@[^,@; \r\n]+\\.[^,@; \r\n]+$'", name: "valid_email"
    add_column :users, :status, :integer, null: false, default: 1
    rename_column :users, :password, :password_hash
    add_index :users, :email, unique: true, where: "status IN (1, 2)"
    change_column_default :users, :created_at, from: nil, to: -> { "CURRENT_TIMESTAMP" }
    change_column_default :users, :updated_at, from: nil, to: -> { "CURRENT_TIMESTAMP" }

    # Used by the password reset feature
    create_table :user_password_reset_keys, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :users, column: :id
      t.string :key, null: false
      t.datetime :deadline, null: false
      t.datetime :email_last_sent, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end

    # Used by the account verification feature
    create_table :user_verification_keys, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :users, column: :id
      t.string :key, null: false
      t.datetime :requested_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.datetime :email_last_sent, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end

    # Used by the verify login change feature
    create_table :user_login_change_keys, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :users, column: :id
      t.string :key, null: false
      t.string :login, null: false
      t.datetime :deadline, null: false
    end

    # Used by the remember me feature
    create_table :user_remember_keys, id: false do |t|
      t.bigint :id, primary_key: true
      t.foreign_key :users, column: :id
      t.string :key, null: false
      t.datetime :deadline, null: false
    end
  end
end
