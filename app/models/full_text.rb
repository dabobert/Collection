class FullText < ActiveRecord::Base
  belongs_to :textable, :polymorphic=>true
	
	validates_presence_of :text
	
	def to_s
	  text
  end
end
