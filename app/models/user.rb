class User < ActiveRecord::Base
	has_many :events, through: :join_tables
	has_many :join_tables, dependent: :destroy
  	has_secure_password
  	validates :first_name, :last_name, :email, presence: true
  	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  	validates :email, uniqueness: { :case_sensitive => false }
end
