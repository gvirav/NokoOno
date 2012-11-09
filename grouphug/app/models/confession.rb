require_relative '../../db/config'

class Confession < ActiveRecord::Base
  belongs_to :user
  validates :post_id, :presence => true
end
