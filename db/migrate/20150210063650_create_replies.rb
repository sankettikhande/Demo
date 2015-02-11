class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string   "note"
      t.integer  "complaint_id"
      t.integer  "replier_id"
      t.string   "replier_type"
      t.datetime "created_at",null: false
      t.datetime "updated_at",null: false

      t.timestamps
    end
  end
end
