require 'salt'

# config class to merge configurations
module Salt
  class Config < Hash
    def initialize(*h_list)
      return if h_list.empty?
      h_list.compact.each  { |h| self.merge!(h) }
    end

    def has_keys?(mandatory_keys)
      mandatory_keys.all? { |k| self.include?(k) }
    end
    
  end
end
