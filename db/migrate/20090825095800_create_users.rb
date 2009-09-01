class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login, :null => false
      t.string :email, :null => false

      # Additional columns that will be maintained by authlogic. See plugin doc.
      t.string :crypted_password   # may be null on signup process
      t.string :password_salt      # may be null on signup process
      t.string :persistence_token, :null => false # required
      t.string :perishable_token,  :null => false # optional, see Authlogic::Session::Perishability

      # Authlogic::Session::MagicColumns
      t.integer :login_count,        :null => false, :default => 0 # optional
      t.integer :failed_login_count, :null => false, :default => 0 # optional
      t.datetime  :last_request_at                                 # optional
      t.datetime :current_login_at                                 # optional
      t.datetime  :last_login_at                                   # optional
      t.string    :current_login_ip                                # optional
      t.string    :last_login_ip                                   # optional

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
