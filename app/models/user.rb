# frozen_string_literal: true

# Template instructions: add any tables related to User here
class User < ApplicationRecord
  include Authentication
  has_many :examples
  has_many :movies
end
