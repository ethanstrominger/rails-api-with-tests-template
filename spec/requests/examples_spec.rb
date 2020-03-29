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

  def example_params
    {
      text: 'Example 1'
    }
  end

  def example_params2
    {
      text: 'Example 2'
    }
  end

  def example_params3
    {
      text: 'Example 3'
    }
  end

  def examples
    Example.all
  end

  def example
    Example.first
  end

  def example_last
    Example.last
  end

  before(:all) do
    signup_and_in
    # Example.create!(example_params2)
    # Example.create!(example_params3)
  end

  after(:all) do
    Example.delete_all
  end

  describe 'GET /examples' do
    it 'lists all examples xxxxxxxx' do
      print 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      print headers
      print 'asdfasdfadsfdsfsdfasdfsdf'
      get '/examples', headers: headers
      #
      # expect(response).to be_success
      #
      # examples_response = JSON.parse(response.body)
      # expect(examples_response.length).to eq(examples.count)
      # expect(examples_response.first['title']).to eq(example['title'])
    end
  end

  # describe 'GET /examples/:id' do
  #   it 'shows one example' do
  #     get "/examples/#{example.id}"
  #     expect(response).to be_successful
  #
  #     example_response = JSON.parse(response.body)
  #     expect(example_response['id']).not_to be_nil
  #     expect(example_response['title']).to eq(example['title'])
  #     # expect(example_response['title']).to eq(example_params['title'])
  #   end
  # end
  #
  # describe 'DELETE /examples/:id' do
  #   it 'deletes an example' do
  #     last_id = example_last.id
  #     delete "/examples/#{last_id}"
  #     expect(response).to be_successful
  #     example_exists = Example.exists?(last_id)
  #     expect(example_exists).to eq(false)
  #     # expect(example_last).to be_nil
  #   end
  # end
  #
  # describe 'PATCH /examples/:id' do
  #   def example_diff
  #     { title: 'Two Stupid Tricks' }
  #   end
  #
  #   it 'updates an example' do
  #     patch "/examples/#{example.id}", params: { example: example_diff }
  #     expect(response).to be_successful
  #   end
  # end
  #
  # describe 'POST /examples' do
  #   new_values = {
  #     title: 'New Stupid tricks',
  #     content: 'Stupid content'
  #   }
  #   it 'creates an example' do
  #     post '/examples', params: { example: new_values }
  #     last_record = Example.last
  #     expect(last_record['title']).to eq(new_values[:title])
  #   end
  # end
end
