module Manager
  module Settings
    class General < ::Manager::Admin
      # provides :xml, :yaml, :js
  
      def index
        @settings = Setting.all(:type => :general)
        display @settings
      end
  
      def show(id)
        @setting = Setting.get(id)
        raise NotFound unless @setting
        render :edit
      end
  
      def new
        only_provides :html
        @setting = Setting.new
        display @setting
      end
  
      def edit(id)
        only_provides :html
        @setting = Setting.get(id)
        raise NotFound unless @setting
        display @setting
      end
  
      def create(setting)
        @setting = Setting.new(setting)      
        if @setting.save
          redirect resource(:manager, :settings, :general), :message => {:notice => "Settings was successfully created"}
        else
          message[:error] = "Settings failed to be created"
          render :new
        end
      end
  
      def update(id, settings)
        @settings = Setting.get(id)
        raise NotFound unless @settings
        if @settings.update_attributes(settings)
           redirect resource(:manager, @settings)
        else
          display @settings, :edit
        end
      end
  
      def destroy(id)
        @settings = Setting.get(id)
        raise NotFound unless @settings
        if @settings.destroy
          redirect resource(:manager, :settings, :general)
        else
          raise InternalServerError
        end
      end
    end
  end # Posts
end # Manager
