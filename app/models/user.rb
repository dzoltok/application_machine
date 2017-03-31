class User < ActiveRecord::Base
  has_many :applications, dependent: :destroy
  has_many :activities, class_name: 'UserActivity', dependent: :destroy

  validates :email_address, presence: true, email_format: true
end
