require 'swagger_helper'

RSpec.describe 'api/users/:id/posts/:id', type: :request do
  path '/api/users/{user_id}/posts/{id}/comments' do
    post 'Create comments' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :integer, description: 'id'
      parameter name: 'user_id', in: :path, type: :integer, description: 'user_id'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          author_id: { type: :integer },
          post_id: { type: :integer }
        },
        required: %w[text author_id post_id]
      }

      response '201', 'Comment created' do
        let!(:comment) { create(:comment) }
        run_test!
      end
    end
  end

  path '/api/users/{user_id}/posts/{id}' do
    get 'Retrieve comment' do
      tags 'Comments'
      produces 'application/json'
      parameter name: 'id', in: :path, type: :integer, description: 'id'
      parameter name: 'user_id', in: :path, type: :integer, description: 'user_id'

      response('200', 'comment retrieved') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   text: { type: :string },
                   author_id: { type: :integer },
                   post_id: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string }
                 }
               }
        let!(:user) { create(:user) }
        let(:auth_token) { user.auth_token }
        let(:id) { Comment.create(user_id: user.id, content: 'My Comment').id }
        run_test!
      end
    end
  end
end
