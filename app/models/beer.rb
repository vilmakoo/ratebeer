class Beer < ActiveRecord::Base
	include RatingAverage
	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user
	validates :name, length: { minimum: 1 }

	def to_s
		merkkijono = self.name + ", " + self.brewery.name
	end

end
