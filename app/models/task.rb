class Task < ActiveRecord::Base
  validates :description, presence: true
  validates :assigned_to, presence: true
  validates :due_at, presence: true
end
