class Event < ActiveRecord::Base
	has_many :users, through: :join_tables
	has_many :join_tables, dependent: :destroy
	has_many :comments, dependent: :destroy
	validates :name, :date, :location, :state, presence: true
end
