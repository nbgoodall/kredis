# Adds a set of integer keys such that we don't use KEYS for `Record.all` lookups. Useful for migrations.
module Kredis::Record::Ids
  extend ActiveSupport::Concern

  included do
    delegate :insert_id_in_lookup_set, to: :class
    attribute :id, :integer
  end

  class_methods do
    kredis_set :ids, typed: :integer, key: ->(m) { "#{kredis_collection_key}:ids" }

    def insert_id_in_lookup_set
      ids << rand(1_000_000)
    end
  end
end
