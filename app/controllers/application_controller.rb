class ApplicationController < ActionController::Base
  
  def top_item
    @new_items = Item.last(4)
  end
  
end
