# frozen_string_literal: true

# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /api/v1/users' do
    let(:valid_attributes) do
      {
        user: {
          email: 'user@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end

    context 'when the request is valid' do
      it 'creates a user and returns a 201 response' do
        post '/api/v1/users', params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(json['message']).to eq('User created successfully')
        expect(json).to have_key('api_key')
      end
    end

    context 'when the request is invalid' do
      it 'returns a 422 response for missing password' do
        post '/api/v1/users', params: { user: { email: 'user@example.com' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors']).to include("Password can't be blank")
      end

      it 'returns a 422 response for mismatched password confirmation' do
        post '/api/v1/users', params: {
          user: {
            email: 'user@example.com',
            password: 'password123',
            password_confirmation: 'different_password'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors']).to include("Password confirmation doesn't match Password")
      end
    end
  end

  describe 'POST /api/v1/users/show_api_key' do
    let!(:user) { create(:user) }

    context 'when the credentials are invalid' do
      before { post '/api/v1/users/show_api_key', params: { email: user.email, password: 'wrong_password' } }

      it 'returns a 401 response' do
        expect(response).to have_http_status(:unauthorized)
        expect(json['error']).to eq('Invalid email or password')
      end
    end
  end

  describe 'POST /api/v1/users/regenerate_api_key' do
    let!(:user) { create(:user) }

    context 'when the credentials are invalid' do
      before { post '/api/v1/users/regenerate_api_key', params: { email: user.email, password: 'wrong_password' } }

      it 'returns a 401 response' do
        expect(response).to have_http_status(:unauthorized)
        expect(json['error']).to eq('Invalid email or password')
      end
    end
  end
end
