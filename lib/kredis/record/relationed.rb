module Kredis::Record::Relationed
  extend ActiveSupport::Concern

  include ActiveRecord::Core, ActiveRecord::Persistence # Base off of the core methods then extend as needed.

  def all
    where(id: ids.members) # Could maybe instantiate a Relation with includes_values = ids.members.
  end

  def where(id:)
    multi do
      Array(id).map { |known_id| new(id: known_id) }
    end
  end

  def find(id)
    new id: id
  end
end
