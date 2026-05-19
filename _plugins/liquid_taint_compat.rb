# Ruby 3.2 removed taint tracking APIs that older Liquid releases still call.
# Jekyll 4.2.x can still pull in Liquid 4.0.3 via the lockfile, so we provide
# a tiny compatibility shim to keep local preview working.
unless ''.respond_to?(:tainted?)
  class Object
    def tainted?
      false
    end
  end
end

class File
  class << self
    alias_method :exists?, :exist? unless method_defined?(:exists?)
  end
end
