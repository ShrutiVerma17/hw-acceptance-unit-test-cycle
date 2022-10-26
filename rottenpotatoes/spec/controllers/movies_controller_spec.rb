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

  describe 'GET index' do
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    it 'creates a new movie' do
      expect {post :create, movie: {:title => "Random Movie 4"}}.to change {Movie.count}.by(1)
    end
  end

  describe 'DELETE #destroy' do
    Movie.create(:title=> "Random Movie 5", :director=>"Steven Spielberg")
    # movie_id = Movie.find_by(:title => "Random Movie 5").id
    # byebug
    it 'destroys movie' do
      expect {delete :destroy, id: Movie.first.id}.to change{Movie.count}.by(-1)
    end
  end
end