module ActiveShard
  module Job
    extend ActiveSupport::Concern

    included do
      around_perform do |_, block|
        ActiveShard.set(@shard, role: @role) do
          block.call
        end
      end
    end

    def serialize
      super.merge(
        'ROLE' => ActiveShard::Record.current_role.to_s,
        'SHARD' => ActiveShard::Record.current_shard.to_s
      )
    end

    def deserialize(job_data)
      super

      @role  = job_data['ROLE']&.to_sym || :writing
      @shard = job_data['SHARD']&.to_sym || :default
    end
  end
end

ActiveSupport.on_load(:active_job) do
  include ActiveShard::Job
end
