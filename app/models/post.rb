class Post < ApplicationRecord

  belongs_to :user

  validates :name,presence:true
  validates :caption,presence:true,length:{maximum:30}

  has_one_attached:image

  def get_image(width,height)
    unless image.attached?
    file_path = Rails.root.join('app/assets/images/snow.png')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
   image.variant(resize_to_limit: [width,height]).processed
  end
end
