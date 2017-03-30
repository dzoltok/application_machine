class UserActivity < ActiveRecord::Base
  belongs_to :user

  def private_details
    super || public_details
  end
end
