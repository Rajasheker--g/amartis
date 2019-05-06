module Addressable
  extend ActiveSupport::Concern

  included do
    has_one :address, as: :addressable, dependent: :destroy
  end
end