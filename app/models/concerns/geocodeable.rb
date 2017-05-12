module Geocodeable

  extend ActiveSupport::Concern

  included do
    after_validation :geocode
    acts_as_mappable
    geocoded_by :address, latitude: :lat, longitude: :lng
  end

end