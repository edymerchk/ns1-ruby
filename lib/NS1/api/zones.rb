module NS1
  module API
    module Zones
      def zones
        request(:get, "zones")
      end

      def zone(zone)
        request(:get, "zones/#{zone}")
      end

      def create_zone(zone, params = {})
        params = params.merge(zone: zone)
        request(:put, "zones/#{zone}", params.to_json)
      end

      def update_zone(zone, params = {})
        request(:post, "zones/#{zone}", params.to_json)
      end

      def delete_zone(zone)
        request(:delete, "zones/#{zone}")
      end
    end
  end
end