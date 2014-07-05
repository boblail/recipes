module CoreExt
  module Enumerable
  
    def avg
      return nil if length.zero?
      sum.to_f / length
    end
  
  end
end

Array.send :include, CoreExt::Enumerable
