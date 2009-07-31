module Manager
  class PostsController < AdminController
    # provides :xml, :yaml, :js
  
    def index
      @posts = Post.all
      
      respond_to do |format|
        format.html
        format.xml  { render :xml => @posts }
      end
    end
  
    def show(id)
      @post = Post.get(id)
      raise NotFound unless @post
      render :edit
    end
  
    def new
      @post = Post.new
      respond_to do |format|
        format.html
      end
    end
  
    def edit
      only_provides :html
      @post = Post.get(id)
      raise NotFound unless @post
      display @post
    end
  
    def create
      @post = Post.new(params[:post])

      respond_to do |format|
        if @post.save
          flash[:notice] = 'Post was successfully created.'
          format.html { redirect_to(@post) }
          format.xml  { render :xml => @post, :status => :created,
    	                :location => @post }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @post.errors,
    	                :status => :unprocessable_entity }
        end
      end
      
      
      @post = Post.new(post)
      @post.user_id = self.session.user.id
      
      if @post.save
        redirect resource(:manager, @post), :message => {:notice => "Post was successfully created"}
      else
        message[:error] = "Post failed to be created"
        render :new
      end
    end
  
    def update(id, post)
      @post = Post.get(id)
      raise NotFound unless @post
      if @post.update_attributes(post)
         redirect resource(:manager, @post)
      else
        display @post, :edit
      end
    end
  
    def destroy(id)
      @post = Post.get(id)
      raise NotFound unless @post
      if @post.destroy
        redirect resource(:posts)
      else
        raise InternalServerError
      end
    end
  
  end # Posts
end # Manager
