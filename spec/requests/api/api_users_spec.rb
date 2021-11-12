require 'swagger_helper'

RSpec.describe 'api/users/register', type: :request do
  path '/api/users/register' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[name email password]
      }

      response '201', 'User created' do
        let!(:user) { create(:user) }
        run_test!
      end
    end
  end
  # path '/api/users/login' do
  #   post 'Sign up a user' do
  #     tags 'Users'
  #     consumes 'application/json'
  #     parameter name: :user, in: :body, schema: {
  #       type: :object,
  #       properties: {
  #         email: { type: :string },
  #         password: { type: :string }
  #       },
  #       required: %w[email password]
  #     }

  #     response '200', 'user logged in' do
  #     end
  #   end
  # end
end
