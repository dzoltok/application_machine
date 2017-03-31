class User < ActiveRecord::Base
  has_many :applications
  has_many :activities, class_name: 'UserActivity'

  validates :email_address, presence: true, email_format: true

  private
end
