# class to create salt roles
require 'salt'

class SaltFactory
  def initialize(info)
    @info = info
  end
  
  def create
    hostlist = {}
    @info["hosts"].each do |n, v|
      hostlist[n] = _createhost(n, v)
      hostlist[n].attrib["memory"] = v['memory'] || @info['defaults']['memory']
      hostlist[n].attrib["cpus"] = v['cpus'] || @info['defaults']['cpus']
                                             
    end

    # now that all objects are created, set their masters and syndics
    hostlist.each do |n, v|
      v.master = hostlist[@info['hosts'][n]['master']]

      if v.respond_to?(:syndic_master)
        v.syndic_master = hostlist[@info['hosts'][n]['syndic_master']]
      end
    end
    
    return hostlist
  end
  
  private
  
  def _createhost(name, info)

    # we'll initialize the class based on the role listed in the config file
    klass = "Salt::" + info["role"].capitalize
    
    return Kernel.const_get(klass).new(name, info, @info["roles"][info["role"]])
  end
  
end

