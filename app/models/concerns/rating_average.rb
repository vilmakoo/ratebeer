module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    taulukko = self.ratings.to_a
    taulukko.map! {|a| a.score}
    summa = taulukko.inject {|summa, rating| summa + rating}
    keskiarvo = summa.to_f / taulukko.size
  end
end