module Her
  module Model
    module Introspection

      # Handles missing methods by routing them through @data
      # @private
      def method_missing(method, attrs=nil) # {{{
        assignment_method = method.to_s =~ /\=$/
        method = method.to_s.gsub(/(\?|\!|\=)$/, "").to_sym
        if attrs and assignment_method
          @data[method.to_s.gsub(/\=$/, "").to_sym] = attrs
        else
          if @data.include?(method)
            @data[method]
          else
            super
          end
        end
      end # }}}

      # Inspect an element, returns it for introspection.
      #
      # @example
      #   class User
      #     include Her::Model
      #   end
      #
      #   @user = User.find(1)
      #   p @user # => #<User(/users/1) id=1 name="Tobias Fünke">
      def inspect # {{{
        "#<#{self.class}(#{self.class.build_request_path(@data)}) #{@data.inject([]) { |memo, item| key, value = item; memo << "#{key}=#{attribute_for_inspect(value)}"}.join(" ")}>"
      end # }}}

      private
      # @private
      def attribute_for_inspect(value) # {{{
        if value.is_a?(String) && value.length > 50
          "#{value[0..50]}...".inspect
        elsif value.is_a?(Date) || value.is_a?(Time)
          %("#{value}")
        else
          value.inspect
        end
      end # }}}
    end
  end
end
