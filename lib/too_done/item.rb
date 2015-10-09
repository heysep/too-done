module TooDone 
	class Item < ActiveRecord::Base 
		belongs_to :list
	end
end