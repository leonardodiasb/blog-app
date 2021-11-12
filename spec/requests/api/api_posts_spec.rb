require 'swagger_helper'

RSpec.describe 'api/users/:id/posts', type: :request do
  path '/api/users/{user_id}/posts' do
    get 'Retrieves posts' do
      tags 'Posts'
      produces 'application/json'
      parameter name: 'user_id', in: :path, type: :integer, description: 'user_id'

      response('200', 'posts retrieved') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   comments_counter: { type: :integer },
                   likes_counter: { type: :integer },
                   author_id: { type: :integer },
                   post_id: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 }
               }
        let!(:user) { create(:user) }
        let(:auth_token) { user.auth_token }
        let(:id) { Post.create(user_id: user.id, content: 'My Post').id }
        run_test!
      end
    end
  end
end
