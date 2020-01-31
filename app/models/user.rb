class User < ApplicationRecord
  attr_accessor :remember_token
  after_create :remember
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
    
  # Returns a random token.
  def User.new_token
    Digest::SHA1.hexdigest SecureRandom.urlsafe_base64.to_s
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
