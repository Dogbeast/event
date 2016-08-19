class Comment < ActiveRecord::Base
  belongs_to :event
  validates :comment, presence: true
end
