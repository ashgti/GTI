module Manager
  module Settings
    class AbstractSettings < ::Manager::Admin
      # provides :xml, :yaml, :js
  
      def index
        @settings = Settings.all(:type => :general)
        # display @posts
        # 'index'
      end
  
      def show(id)
        #@post = Settings.get(id)
        #raise NotFound unless @post
        #render :edit
        
        'show'
      end
  
      def new
        only_provides :html
        @post = Post.new
        display @post
      end
  
      def edit(id)
        only_provides :html
        @post = Post.get(id)
        raise NotFound unless @post
        display @post
      end
  
      def create(post)
        @post = Post.new(post)
        @post.user_id = self.session.user.id
      
        Merb.logger.debug "\n\nSession User: #{self.session.user.class} and #{self.session.user.inspect}\n\n"
      
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
    end
  end # Posts
end # Manager
