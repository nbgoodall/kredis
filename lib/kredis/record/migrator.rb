module Kredis::Record::Migrator
  extend ActiveSupport::Concern

  class_methods do
    def migrate_to_active_record(record_klass)
      all.map(&:attributes).in_groups_of(1_000).each do |batch|
        record_klass.create! batch
      end
    end

    def remove_migrated_data
      delete_all
      ids.clear
    end
  end
end
