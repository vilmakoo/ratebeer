class Brewery < ActiveRecord::Base
	include RatingAverage
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers
	validates :name, length: { minimum: 1 }
	validates :year, numericality: { greater_than_or_equal_to: 1042,
																		#less_than_or_equal_to: 2016,
																		only_integer: true }
	validate :year_cannot_be_in_the_future


	def year_cannot_be_in_the_future
		if year > Date.current.year
			errors.add(:year, "can't be in the future")
		end
	end

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end

	def restart
		self.year = 2016
		puts "changed year to #{year}"
	end

end
