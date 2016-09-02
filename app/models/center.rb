class Center < ActiveRecord::Base
  attr_accessor :reset_token
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { minimum: 6 }, uniqueness: true
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = Center.new_token
    update_columns(reset_digest: Center.digest(reset_token), reset_sent_at: Time.zone.now)
    # update_attribute(:reset_digest,  Center.digest(reset_token))
    # update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    CenterMailer.password_reset(self).deliver_now
  end

  # Returns a random token.
  def Center.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns the hash digest of the given string.
  def Center.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end
end
