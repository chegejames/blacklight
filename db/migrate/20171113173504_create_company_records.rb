class CreateCompanyRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :company_records do |t|
      t.string :name
      t.string :regno
      t.string :status
      t.string :director_id

      t.timestamps
    end
  end
end
