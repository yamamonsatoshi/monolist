class RankingsController < ApplicationController
  before_action :logged_in_user
  
  def have
    top_num = 10
    # have_usersの人数でsortする
    @top_haves = Item.all.sort{ |i1, i2| 
      i2.have_users.count <=> i1.have_users.count
    }.first(top_num)
  end
  
  def want
    top_num = 10
    # want_usersの人数でsortする
    @top_wants = Item.all.sample(10)
    @top_wants = Item.all.sort{ |i1, i2| 
      i2.want_users.count <=> i1.want_users.count
    }.first(top_num)
  end
end
