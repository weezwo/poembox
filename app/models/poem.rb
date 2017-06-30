class Poem < ActiveRecord::Base
  belongs_to :user
  has_many :ratings
end
