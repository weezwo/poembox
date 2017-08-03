class Poem < ActiveRecord::Base
  belongs_to :user
  has_many :ratings

  validates :content, presence: true
  validates :title, presence: true
end
