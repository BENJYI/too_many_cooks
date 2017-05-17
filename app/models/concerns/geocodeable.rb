module Geocodeable

  extend ActiveSupport::Concern

  included do
    after_validation(:geocode) unless Rails.env.test?
    acts_as_mappable
    geocoded_by :address, latitude: :lat, longitude: :lng
  end

  def to_google_maps_coords
    self.to_coordinates.join(",")
  end

end