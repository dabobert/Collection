module Swingable

    def self.included(base)
        base.extend(ClassMethods)
    end

    def instance_swing
        puts 'Did an instance swing!'
    end

    module ClassMethods
        def static_swing
            puts 'Did a static swing!'
        end
        
        def foo value
          value.upcase!
          Kernel.const_get(self.class.name).find(:all, :conditions=>["name = ?",value]) || Kernel.const_get(self.class.name).create(:name=>value)
        end
    end
end