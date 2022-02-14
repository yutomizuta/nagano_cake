class Public::EndUsersController < ApplicationController

  def show
  end

  def edit
    @end_user = current_end_user
  end
  
  def unsubscribe
  end
  
  def withdraw
  end
end
