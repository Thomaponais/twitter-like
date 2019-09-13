class User < ActiveRecord::Base
  authenticates_with_sorcery!
  acts_as_voter
  acts_as_follower
  acts_as_followable
  attr_accessor :current_password

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true
  validates :username, uniqueness: true
  validates :email, uniqueness: true, email_format: { message: ':フォーマットが違います' }
  validate :current_password_is_correct, if: :validate_password?, on: :update
	has_one_attached :avatar
	after_commit :add_default_avatar, on: [:create, :update]
	has_many :tweets, dependent: :destroy

  private
    def add_default_avatar
      unless avatar.attached?
        self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_avatar.png")), filename: 'default_avatar.png' , content_type: "image/jpg")
      end
    end

    def current_password_is_correct
      if User.find(id).valid_password?(current_password) == false
        errors.add(:current_password, "が登録されたパスワードと違います")
      end
    end

    def validate_password?
      !current_password.blank?
    end

end
