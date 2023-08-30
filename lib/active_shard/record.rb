module ActiveShard
  class Record < ApplicationRecord
    self.abstract_class = true

    connects_to shards: Rails.application.config_for(:shards)

    def guid
      [Bank.current_id, id].compact.join('.')
    end
  end
end
