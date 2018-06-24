class User < ApplicationRecord
    before_save   { email.downcase! }
    validates :name , presence: true , length: {maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email , presence: true, length: {maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
             uniqueness:{case_sensitive:false}
    has_secure_password
    validates :password , presence: true ,length:{ minimum: 6 } ,allow_nil: true
    has_many :favorites, class_name:  "Favorite",
                                  foreign_key: "favor_id",
                                  dependent:   :destroy
    has_many :passive_favorites, class_name:  "Favorite",
                                  foreign_key: "favored_id"
    has_many :favoring, through: :favorites, source: :favored
    has_many :favored, through: :passive_favorites, source: :favor

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def favorite?(other_user)
    return (self.favoring.include?(other_user) or self.favored.include?(other_user) )
  end
  
  def matched
    list = Favorite.match.where('favored_id = ? or favor_id = ?', self.id, self.id )
    user_list = []
    list.each do |favorite|
      user_list.push(favorite.other_user(self))
    end 
    return user_list 
  end
  
  def favored_matching
    list = Favorite.matching.where('favored_id = ?', self.id )
    user_list = []
    list.each do |favorite|
      user_list.push(favorite.other_user(self))
    end 
    return user_list 
  end
  
end
