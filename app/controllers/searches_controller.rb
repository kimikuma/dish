class SearchesController < ApplicationController
  def search
    @model=params[:model]
    @word=params[:word]
    @search=params[:search]

   if @model=="user"
     @users=User.search_for(@search,@word)
   else
     @posts=Post.search_for(@seach,@word)
   end
  end

end
