# frozen_string_literal: true

require 'rails_helper'
require 'requests/auth_helper'

RSpec.configure do |c|
  c.include AuthHelper
end

RSpec.describe 'Authentication API' do
  before(:all) do
    User.delete_all
  end

  after(:all) do
    User.delete_all
  end

  context 'without an account' do
    describe 'POST /sign-up', describe_name: 'signup' do
      it 'creates a new user' do
        post '/sign-up', params: { credentials: user_params }

        expect(response).to be_successful

        parsed_response = JSON.parse(response.body)
        expect(
          parsed_response['user']['email']
        ).to eq(user_params[:email])
      end
    end
  end

  context 'with an account' do
    before(:all) do
      post '/sign-up', params: { credentials: user_params }
    end

    describe 'POST /sign-in', describe_name: 'signin' do
      it 'returns a token' do
        post '/sign-in', params: { credentials: user_params }

        expect(response).to be_successful

        parsed_response = JSON.parse(response.body)
        expect(
          parsed_response['user']['email']
        ).to eq(user_params[:email])
        expect(
          parsed_response['user']['token']
        ).not_to be_empty
      end
    end
  end

  context 'while signed in' do

    before(:each) do
      signup_and_in
      # post '/sign-up', params: { credentials: user_params }
      # post '/sign-in', params: { credentials: user_params }
      #
      # @token = JSON.parse(response.body)['user']['token']
      # @user_id = JSON.parse(response.body)['user']['id']
    end

    describe 'PATCH /change-password/', describe_name: 'changepw' do
      def new_password_params
        {
          old: 'foobarbaz',
          new: 'foobarbazqux'
        }
      end

      it 'changes password' do
        patch '/change-password/',
              params: { passwords: new_password_params },
              headers: headers

        expect(response).to be_successful
        expect(response.body).to be_empty
      end
    end

    describe 'DELETE /sign-out/', describe_name: 'signout' do
      it 'is successful' do
        delete '/sign-out/', headers: headers

        expect(response).to be_successful
        expect(response.body).to be_empty
      end

      it 'expires the token' do
        delete '/sign-out/', headers: headers
        delete '/sign-out/', headers: headers

        expect(response).not_to be_successful
      end
    end
  end
end
