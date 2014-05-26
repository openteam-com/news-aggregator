HasSearcher.create_searcher :entries do
  models :entry

  property :source

  keywords :q do
    highlight :title
  end

  scope(:order_by_rating) { order_by(:rating, :desc) }

  scope :newest do
    with(:published_at).greater_than DateTime.now - 12.hour
  end
  scope :today do
    with(:published_at).greater_than DateTime.now.beginning_of_day
  end
  scope :weekly do
    with(:published_at).greater_than Time.zone.now - 7.days
  end
  scope :monthly do
    with(:published_at).greater_than Time.zone.now - 30.days
  end
  scope :alltime do
    with(:published_at).less_than Time.zone.now
  end
  scope :threedays do
    with(:published_at).greater_than DateTime.now.beginning_of_day - 3.days
  end

  scope :rating do
    order_by(:rating, :desc)
  end

  scope :novelty do
    order_by(:published_at, :desc)
  end
end
