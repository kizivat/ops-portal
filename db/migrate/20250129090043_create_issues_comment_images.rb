class CreateIssuesCommentImages < ActiveRecord::Migration[8.0]
  def change
    create_table :issues_comment_images do |t|
      t.string :path
      t.references :comment, null: false, foreign_key: { to_table: :issues_comments }

      t.timestamps
    end
  end
end
