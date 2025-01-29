class CreateIssuesImages < ActiveRecord::Migration[8.0]
  def change
    create_table :issues_images do |t|
      t.string :path
      t.string :thumbnail
      t.string :original
      t.references :object, polymorphic: true
      t.integer :position

      t.timestamps
    end
  end
end
