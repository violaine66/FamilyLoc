class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        has_many :reservations, dependent: :destroy

  after_create :send_welcome_email, if: -> { Rails.env.development? }
  scope :admin, -> { where(admin: true) }

  def admin?
    self[:admin] == true
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
