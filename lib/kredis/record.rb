class Kredis::Record
  include ActiveModel::Model # Maybe just the pieces of this are needed.
  include Ids, Relationed, Migrator

  def self.kredis_collection_key
    # TODO: Needs namespace support or general purpose key extraction API.
    # `base_class` depends on https://github.com/rails/rails/pull/41252
    "kredis:models:#{base_class.name.tableize.gsub("/", ":")}"
  end
  delegate :kredis_collection_key, to: :class

  def initialize(id: nil, **attributes)
    @id = id || insert_id_in_lookup_set
    @hash = Kredis.hash("#{kredis_collection_key}:#{@id}") # Potentially needs to have types injected here.
    @attributes = hash.elements.merge(**attributes) # Probably can't override attributes
  end
end
