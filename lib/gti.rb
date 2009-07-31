

# Class for general Bloggery Stuff
module GTI
  class << self
    def callback key
      @keywords[key] 
    end
    
    def config &block
      GTI::Config.configure(&block) if block_given?
      Config
    end
    
    def register open, close, &block
      @keywords[symbol] ||= keyword
    end
  end
end

require Rails.root.join('lib', 'gti', 'autoload')