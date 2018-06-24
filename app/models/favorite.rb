class Favorite < ApplicationRecord
  belongs_to :favor, class_name: "User"
  belongs_to :favored, class_name: "User"
  
  validates :favor_id, presence: true
  validates :favored_id, presence: true
  
  enum status:{matching: 0, not_match:1, match:2,item:3, undefine:4}
  
  def other_user(user)
    if self.favor_id == user.id
      return self.favored
    elsif self.favored_id == user.id
      return self.favor
    else
      return nil
    end
  end
end
