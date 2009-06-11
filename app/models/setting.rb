class Setting
  include DataMapper::Resource
  
  property :id,       Serial, :serial => true
  property :key,      String
  property :value,    String
  property :auto_load, Boolean
  property :type,     Enum[:general, :misc, :user, :permalinks]
  
  class << self
    def get_auto_loads 
      result = {}
      all(:auto_load => true).each do |t|
        result[t.key.to_sym] = t.value
      end
      result
    end
  end
end