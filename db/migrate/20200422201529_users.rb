rake db:migrate SINATRA_ENV=testclass users < ActiveRecord::Migration
  def change
  create_table :users do |t|
    t.string :name
    t.string :email
    t.string :password
  end
end
