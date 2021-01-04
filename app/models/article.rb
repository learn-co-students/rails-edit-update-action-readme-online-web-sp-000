class Article < ActiveRecord::Base

  validates :title, :description, presence: true
end