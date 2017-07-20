class RemoveIndexEmail < ActiveRecord::Migration[5.1]
  def change
    remove_index "email", name: "index_users_on_email"
  end
end
