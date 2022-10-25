require 'rails_helper'

describe MoviesController do
  describe 'Find movies with the same director' do
    it 'should call Movie.others_by_same_director' do 
      expect(Movie).to receive(:others_by_same_director).with('Star Wars')
      get :search_same_director, {title: 'Star Wars'}
    end

    it 'should find similar movies if director exists' do
      movies = ['THX-1138']
      expect(Movie).to receive(:others_by_same_director).with('Star Wars').
        and_return(movies)
      get :search_same_director, {:title => 'Star Wars'}
      expect(assigns(:movies_with_same_director)).to eql(movies)
    end

    it 'should not return matches if director is not specified' do
      expect(Movie).to receive(:others_by_same_director).with('Alien').
        and_return(nil)
      get :search_same_director, {title: 'Alien'}
      expect(assigns(:movies_with_same_director)).to be_nil
      expect(response).to redirect_to(root_url)
    end
  end
end