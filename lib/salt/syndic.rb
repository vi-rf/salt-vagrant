module Salt
  class Syndic < Master
    attr_accessor :syndic_master
    
    def setDefaults(salt)
      salt.install_syndic = true

      super
      
    end
  end
end

