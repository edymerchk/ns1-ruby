module NS1
  module API
    module Records
      def record(zone, domain, type)
        request(:get, "zones/#{zone}/#{domain}/#{type}")
      end

      def create_record(zone, domain, type, params = {})
        params = params.merge(zone: zone, domain: domain, type: type)
        request(:put, "zones/#{zone}/#{domain}/#{type}", params.to_json)
      end

      def update_record(zone, domain, type, params = {})
        request(:post, "zones/#{zone}/#{domain}/#{type}", params.to_json)
      end

      def delete_record(zone, domain, type)
        request(:delete, "zones/#{zone}/#{domain}/#{type}")
      end
    end
  end
end