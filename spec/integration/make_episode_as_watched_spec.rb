require 'rails_helper'

RSpec.describe "make episode as watched", :type => :request do
  it "mark episode as watched" do
    user = User.create!(:email => "foo@example.com", :password => "secret123")
    tv_show = TvShow.create!(user_id: user.id, title: 'SOA')
    ep1 = Episode.create!(episode: 1, tv_show_id: tv_show.id, watched: false)
    ep2 = Episode.create!(episode: 2, tv_show_id: tv_show.id, watched: false)
    tv_show.episodes << [ep1, ep2]

    post "/users/sign_in", params: {user: {:email => "foo@example.com", :password => "secret123"}}
    put "/api/v1/episodes/#{ep1.id}", params: {tv_show_id: tv_show.id, episode: { watched: true }}, headers: {"ACCEPT" => "application/json"}
    get '/api/v1/episodes', params: {tv_show_id: tv_show.id} , headers: {"ACCEPT" => "application/json"}

    expect(response.body).to include('true')
  end
end
