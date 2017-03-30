class User < ActiveRecord::Base
  has_many :goals
  has_many :activities, class_name: 'UserActivity'

  validates :email_address, presence: true, email_format: true

  after_create :initialize_goals

  private

  def initialize_goals
    goals.create(goal_type: 'retirement')
    goals.create(goal_type: 'cash')
    goals.create(goal_type: 'education')
  end
end
