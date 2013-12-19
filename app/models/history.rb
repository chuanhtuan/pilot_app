class History < ActiveRecord::Base
  belongs_to :poster, class_name: "User"
  belongs_to :receiver, class_name: "User"
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 512 }
  validates :poster_id, presence: true
  validates :receiver_id, presence: true

  def self.from_poster_with_receiver(poster, receiver)
    where("(poster_id = :poster_id AND receiver_id = :receiver_id) OR (poster_id = :receiver_id AND receiver_id = :poster_id)",
          poster_id: poster, receiver_id: receiver)
  end
end
