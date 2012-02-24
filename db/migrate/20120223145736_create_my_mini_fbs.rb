class CreateMyMiniFbs < ActiveRecord::Migration
  def change
    create_table :my_mini_fbs do |t|

      t.timestamps
    end
  end
end
