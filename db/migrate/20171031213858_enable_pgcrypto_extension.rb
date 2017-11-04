class EnablePgcryptoExtension < ActiveRecord::Migration[5.1]
  def create
    enable_extension 'pgcrypto'
     create_table :reservations, id: :uuid do |t|
      t.text :name
      t.date :from
      t.date :to
      t.timestamps
  end
end
