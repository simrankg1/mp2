require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'


get "/" do 

erb :search
end

post '/results' do
  search_movie = params[:movie]

  response= Typhoeus.get("www.omdbapi.com", :params => {:s => search_movie})
  @movie_list= JSON.parse(response.body)["Search"]
#massive hash of the request made

 	@movie_list.each do |movie|
		response= Typhoeus.get("www.omdbapi.com", :params => {:i => movie['imdb_ID']})
		full_movie_info= JSON.parse(response.body)
		movie= full_movie_info
	end
	erb :results1
end


get '/details/:id' do |id|
	@select_movie = JSON.parse(Typhoeus.get("www.omdbapi.com", :params => {:i => id}).body)

erb :details
end








