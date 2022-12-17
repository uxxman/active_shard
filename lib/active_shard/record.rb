module ActiveShard
  class Record < ApplicationRecord
    self.abstract_class = true

    connects_to shards: Rails.application.config_for(:shards)
  end
end
