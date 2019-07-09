class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: {message: 'doesnt match Password' }, if: -> { new_record? || changes[:crypted_password] }
  validates :username, uniqueness: true
	validates :email, uniqueness: true, email_format: { message: 'has invalid format' }
	has_one_attached :avatar
	after_commit :add_default_avatar, on: [:create, :update]


private 
	def add_default_avatar
  	unless avatar.attached?
    	self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_avatar.png")), filename: 'default_avatar.png' , content_type: "image/jpg")
  	end
	end
has_many :tweets, dependent: :destroy
end
