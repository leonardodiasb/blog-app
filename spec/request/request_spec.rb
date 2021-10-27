require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before { get '/users' }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET #index/id' do
    before { get '/users/23' }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('show')
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('Here is a user')
    end
  end
end

RSpec.describe 'Post', type: :request do
  describe 'GET #users/user_id/post' do
    before { get '/users/23/posts' }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('Here is a list of userx posts')
    end
  end

  describe 'GET #users/user_id/post/id' do
    before { get '/users/23/posts/2' }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('show')
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('Here is a post')
    end
  end
end
