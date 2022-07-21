# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :user_name, null: false, limit: 20
      t.string :title, null: false, limit: 20
      t.text :message, null: false

      t.timestamps null: false
    end
  end
end
