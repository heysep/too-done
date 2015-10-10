module TooDone
  class User < ActiveRecord::Base
    has_many :sessions, dependent: :destroy
    has_many :lists, dependent: :destroy
  end
end
