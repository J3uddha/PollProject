class AddIndices < ActiveRecord::Migration
  def change
    add_index :users, :user_name, unique: :true
    add_index :responses, [:answerchoice_id, :user_id], unique: :true

    add_index :polls, :author_id
    add_index :questions, :poll_id
    add_index :answer_choices, :question_id
    add_index :responses, :answerchoice_id
    add_index :responses, :question_id
    add_index :responses, :user_id
  end
end
