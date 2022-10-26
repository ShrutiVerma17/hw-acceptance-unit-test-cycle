require 'rails_helper'

describe Movie do
  describe '.others_by_same_director' do
    Movie.delete_all
    ids = Movie.find_by(:title =>"Random Movie 1")
    Movie.create(:title=> "Random Movie 1", :director=>"Steven Spielberg")
    Movie.create(:title=> "Random Movie 2", :director=>"Steven Spielberg")
    Movie.create(:title=>"Random Movie 3")
    context 'director exists' do
      it 'finds similar movies' do
        expect(Movie.others_by_same_director('Random Movie 1')).to eq(["Random Movie 1", "Random Movie 2"])
      end
    end
    
    context 'director does not exist' do
      it 'handles sad path' do
        expect(Movie.others_by_same_director('Random Movie 3')).to eql(nil)
      end
    end
  end

  # describe '.all_ratings' do
  #   it 'returns all ratings correctly' do
  #     expect(Movie.all_ratings).to match(["G" "PG" "PG-13" "NC-17" "R"])
  #   end
  # end
end