require_relative '../../db/config'

class User < ActiveRecord::Base
  has_many :confessions
end


