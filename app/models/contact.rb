class Contact < ActiveRecord::Base
  belongs_to :contacted, class_name: "User"
  validates :contact_id, presence: true
  validates :contacted_id, presence: true

end
