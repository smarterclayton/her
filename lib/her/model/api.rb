module Her
  module Model
    # This module interacts with Her::API to fetch HTTP data
    module API
      # Link a model with a Her::API object
      def uses_api(api) # {{{
        #puts "Her::Model::API#uses_api(#{api})"
        @her_api = api
      end # }}}

      # @protected
      def her_api
        #puts "Her::Model::API#her_api #{@her_api} / #{self.class.her_api}"
        @her_api || self.class.her_api
      end

      # Main request wrapper around Her::API. Used to make custom request to the API.
      # @private
      def request(attrs={}, &block) # {{{
        #puts "instance requesting #{attrs.inspect} with #{her_api.inspect}"
        yield her_api.request(attrs)
      end # }}}
    end
  end
end
