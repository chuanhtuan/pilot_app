class User < ActiveRecord::Base
  has_many :histories, foreign_key: "poster_id", dependent: :destroy
  has_many :contacts, foreign_key: "contact_id", dependent: :destroy
  has_many :contacted_users, through: :contacts, source: :contacted
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def histories_with(current_user)
    History.from_poster_with_receiver(current_user, self)
  end

  def post!(history_params)
    @history = current_user.histories.build(history_params)
    @history.save
  end

  def make_contact!(contact_params)
    @contact = self.contacts.build(contact_params)
    @contact.save
  end

  def self.from_not_contacted(user)
    contacted_user_ids = "SELECT contacted_id FROM contacts
                         WHERE contact_id = :user_id"
    where("id NOT IN (#{contacted_user_ids}) AND id <> :user_id",
          contacted_user_ids: contacted_user_ids, user_id: user)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end