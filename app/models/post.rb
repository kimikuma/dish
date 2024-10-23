class Post < ApplicationRecord

  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :comments,dependent: :destroy

  validates :name,presence: true
  validates :caption,presence: true,length: {maximum: 30}

  has_one_attached:image

  def favorited_by?(user)
    favorites.exists?(user_id:user.id)
  end


  def get_image(width,height)
    unless image.attached?
    file_path = Rails.root.join('app/assets/images/snow.png')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
   image.variant(resize_to_limit: [width,height]).processed
  end

  def self.search_for(search,word)
    if search=="perfect"
      Post.where(name: word)
    elsif search=="forward"
      Post.where("name LIKE?",word+"%")
    elsif search=="backward"
      Post.where("name LIKE?","%"+word)
    else search=="partial"
      Post.where("name LIKE?","%"+word+"%")
    end
  end

end

