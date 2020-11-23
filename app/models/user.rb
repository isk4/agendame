class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_one_attached :profile_pic
  has_many :appointments, dependent: :nullify
  validates :name, :email, :phone_number, presence: true
  before_save :capitalize_names

  def profile_pic_url
    self.profile_pic.attachment.service_url
  end

  private

  def capitalize_names
    self.name = self.name.titlecase
  end
end
