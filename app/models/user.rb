# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts
  attr_accessor :remember_token
  before_create :remember
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password
  
  # Returns a random token.
  def self.new_token
    Digest::SHA1.hexdigest SecureRandom.urlsafe_base64.to_s
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    self.remember_digest = remember_token
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
