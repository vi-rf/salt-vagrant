require 'salt/host'

module Salt
  class Minion < Host
    attr_accessor :master
  end
end

# Copyright (C) 2019 by Risk Focus Inc.  All rights reserved
