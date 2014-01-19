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


get '/details/:id' do
	@select_movie = JSON.parse(Typhoeus.get("www.omdbapi.com", :params => {:i => params[:id]}).body)

erb :details
end

# results: 
# 	<%@movie_list.each do |movie| %>
# # 		<li><%= movie["Title"] %> - <%= movie["Year"]%></li>

# post '/details/:imdb' do 
# response= Typhoeus.get("www.omdbapi.com", :params => { i: imdb_id})
# poster_link= JSON.parse(response.body)["Poster"]







