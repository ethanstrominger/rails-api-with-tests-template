# frozen_string_literal: true

require 'rails_helper'

require 'requests/auth_helper'

RSpec.configure do |c|
  c.include AuthHelper
end

RSpec.describe 'Examples', type: :request do
  before(:all) do
    signup_and_in
  end

  after(:all) do
    User.delete_all
  end

  def add_user_id (recordObject)
    recordObject["user_id"] = user_id
    recordObject
  end

  example_params1 = { text: 'Example 1' }
  example_params2 = { text: 'Example 2' }
  example_params3 = { text: 'Example 3' }


  def examples
    Example.all
  end

  def example_first
    Example.first
  end

  def example_last
    Example.last
  end

  before(:all) do
    signup_and_in
    add_user_id (example_params1)
    add_user_id (example_params2)
    add_user_id (example_params3)
    Example.create!(example_params1)
    Example.create!(example_params2)
    Example.create!(example_params3)
  end

  after(:all) do
    Example.delete_all
  end

  describe 'GET /examples' do
    it 'lists all examples' do
      get '/examples', headers: headers
      expect(response).to be_success
      examples_response = JSON.parse(response.body)
      expect(examples_response["examples"].length).to eq(examples.count)
      expect(examples_response["examples"].first['title']).to eq(example_first['title'])
    end
  end

  describe 'GET /examples/:id' do
    it 'shows one example' do
      example_id = example_first['id']
      get "/examples/#{example_id}", headers: headers
      expect(response).to be_successful

      json_response = JSON.parse(response.body)
      example_response = json_response['example']

      expect(example_response['id']).not_to be_nil
      expect(example_response['title']).to eq(example_first['title'])
    end
  end

  describe 'DELETE /examples/:id' do
    it 'deletes an example' do
      last_id = example_last['id']
      delete "/examples/#{last_id}", headers: headers
      expect(response).to be_successful
      example_exists = Example.exists?(last_id)
      expect(example_exists).to eq(false)
    end
  end

  describe 'PATCH /examples/:id' do
    def example_diff
      { text: 'Two Stupid Tricks' }
    end

    it 'updates an example' do
      last_id = example_last['id']
      patch "/examples/#{last_id}",
         params: { example: example_diff },
         headers: headers
      expect(response).to be_successful
    end
  end

  describe 'POST /examples' do
    new_values = {
      text: 'New example'
    }
    it 'creates an example' do
      post '/examples', params: { example: new_values }, headers: headers
      expect(response).to be_successful
      last_record = Example.last
      expect(last_record['text']).to eq(new_values[:text])
    end
  end
end
