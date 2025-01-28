class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.boolean :banned, default: false
      t.string :login
      t.integer :legacy_rights
      t.string :first_name
      t.string :last_name
      t.string :admin_name
      t.string :phone
      t.string :email
      t.string :password
      t.string :about
      t.boolean :organization
      t.datetime :timestamp # TODO Toto nevieme co je
      t.boolean :anonymous, default: false
      t.boolean :active # TODO Toto je len taky odhad co moze boolean status atribut znamenat
      t.references :municipality, null: true, foreign_key: true
      t.boolean :created_from_app, default: false
      t.string :verification # TODO Toto nevieme co je, ci sa hodnota meni alebo nie
      t.boolean :verified, default: false
      t.string :signature
      t.integer :city_id # TODO Toto nevieme co je, referencia na mesto je ocividne municipality a tu nie je vzdy to iste
      t.references :street, null: true, foreign_key: true
      t.boolean :resident
      t.integer :sex
      t.date :birth
      t.string :fcm_token
      t.boolean :gdpr_accepted
      t.string :access_token # TODO Toto nevieme ako sa vyuziva, ci sa meni hodnota alebo nie
      t.integer :exp # TODO Toto nevieme co znamena
      t.boolean :email_notifiable, default: true

      t.timestamps

      t.index :email, unique: true
      t.index :login
      t.index :legacy_rights
      t.index :anonymous
      t.index :active
    end
  end
end
