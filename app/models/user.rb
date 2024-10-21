class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :posts,dependent: :destroy
   has_many :favorites,dependent: :destroy

   has_many :relationships,class_name: "Relationship",foreign_key: :follower_id,dependent: :destroy
   has_many :followings,through: :relationships,source: :followed

   has_many :reverse_relationships,class_name: "Relationship",foreign_key: :followed_id,dependent: :destroy
   has_many :followers,through: :reverse_relationships,source: :follower

   validates :name,presence: true

   has_one_attached:profile_image

   def follow(user)
    relationships.create(followed_id:user.id)
   end

   def unfollow(user)
    relationships.find_by(followed_id:user.id).destroy
   end

   def following?(user)
    followings.include?(user)
   end



   def get_profile_image(width,height)
    unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/snow.png')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
     profile_image.variant(resize_to_limit: [width,height]).processed
   end

end
