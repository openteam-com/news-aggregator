class EntriesWrapper
  attr_accessor :collection

  def initialize(collection)
    @collection = collection
  end

  def collection
    collection_of_entries? ?
      @collection :
      @collection.map { |hit| HitWrapper.new hit }
  end

  def paginateable_collection
    @collection
  end

  private

  def collection_of_entries?
    @collection.first.is_a?(Entry)
  end
end
