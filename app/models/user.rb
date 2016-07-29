class User < ActiveRecord::Base
  has_many :reports

  def self.create_or_update_name(user)
    found_user = User.create_with(account_name: user.screen_name).find_or_create_by(account_id: user.id)
    if found_user.account_name != user.screen_name
      found_user.update_attribute(:account_name, user.screen_name)
    end
    found_user
  end
end
