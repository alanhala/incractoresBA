class User < ActiveRecord::Base
  has_many :reports

  def self.create_or_update_name(user)
    found_user = User.find_or_initialize_by(account_id: user.id)
    if found_user.new_record?
      found_user.account_name = user.screen_name
      found_user.save!
    elsif found_user.account_name != user.screen_name
      found_user.update_attribute(:account_name, user.screen_name)
    end
    return found_user
  end
end
