class BloggerController < ApplicationController
  def show_page
    @content = Page.first(:conditions => {:slug => params[:url]})

    @content.process(request, response)
  end
  
  def not_found
  end

  def error
  end
  
  def post_page
  end
  
  def ajax_response
  end
end # BloggerController
