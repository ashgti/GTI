class Blogger < Application
  provides :xml, :yaml, :js, :html

  def index
    @posts = Post.all
    display @posts
  end

  def show(slug)
    @post = Post.first(:slug => slug)
    raise NotFound unless @post
    display @post
  end
end # Posts
