class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password

  before_save { self.email = email.downcase }

  def self.authenticate_with_credentials(email, password)
    email = email.lstrip.rstrip
    user = User.find_by_email(email.downcase)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
