class Movie < ActiveRecord::Base
    
    def self.others_by_same_director movie_title
      my_director = Movie.find_by(title: movie_title).director
      if (my_director.nil? or my_director == "")
        return nil
      end
      Movie.where(director: my_director).pluck(:title)
    end
end
