require 'fileutils'
require 'openssl'

# class to hide some of the configuration stuff
module Salt
  class Host < Hash
    attr_reader :name
    attr_accessor :master, :keypath

    @@defaults = {keypath: "keys" }
    def self.defaults
      @@defaults
    end

    # create the class with a name and a list of hashes
    def initialize(name, info)
      @name = name

      # this creates the configuration
      self.merge!(info)

      # The pattern
      @keypath = @@defaults[:keypath]

    end

    def role
      self.class.name.split('::').last.downcase
    end

    def ip
      self["ip"]
    end
    
    def pub_key
      @keypath + "/#{@name}.pub"
    end
    
    def pem_key
      @keypath + "/#{@name}.pem"
    end
    
    def keygen
      rsa_key = OpenSSL::PKey::RSA.new(2048)
      Dir.mkdir( @keypath ) unless File.directory?(@keypath )
      
      unless File.exists?(@keypath + "/#{@name}.pem")
        # note we create both, so they match
        File.write(@keypath + "/#{@name}.pem", rsa_key.to_pem.to_s)
        File.write(@keypath + "/#{@name}.pub", rsa_key.public_key.to_s )
      end

    end
    
    # update the salt object with defaults
    def setDefaults(salt)
      salt.colorize = true
      
      # write the keys
      self.keygen
      salt.grains_config = self["grains"]

      salt.minion_pub = pub_key
      salt.minion_key = pem_key      

    end

  end
  
  
end

# Copyright (C) 2019 by Risk Focus Inc.  All rights reserved
