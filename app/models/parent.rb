class Parent < ActiveRecord::Base
  attr_accessor :reset_token
  before_save :downcase_email
  validates :fname, presence: true, length: { maximum: 30 }
  validates :lname, presence: true, length: { maximum: 30 }
  validates :username, presence: true, uniqueness: true, length: { minimum: 6 }
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  has_many :families
  has_many :children, :through => :families
  belongs_to :center

  def parent_full_name
    "#{fname} #{lname}"
  end
 
    # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = Parent.new_token
    update_columns(reset_digest: Parent.digest(reset_token), reset_sent_at: Time.zone.now)
    # update_attribute(:reset_digest,  Parent.digest(reset_token))
    # update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    ParentMailer.password_reset(self).deliver_now
  end

  # Returns a random token.
  def Parent.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns the hash digest of the given string.
  def Parent.digest(string)
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
