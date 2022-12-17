require 'active_shard/job'
require 'active_shard/railtie'

module ActiveShard
  def current
    Record.current_shard
  end

  def set(shard, role: :writing, lock: true, &block)
    return yield if current == shard

    Record.connected_to(shard:, role:) do
      Record.prohibit_shard_swapping(lock, &block)
    end
  rescue ActiveRecord::ConnectionNotEstablished => e
    raise e.message
  end

  def each(role: :writing, exclude: nil, &block)
    Rails.application.config_for(:shards).each_key do |shard|
      next if shard == exclude

      set(shard, role:, &block)
    end
  end

  module_function :set, :each, :current
end
