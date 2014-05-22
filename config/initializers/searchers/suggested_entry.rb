HasSearcher.create_searcher :suggested_entries do
  models :suggested_entry

  keywords :q do
    highlight :title
  end

  scope :interview do
    with(:entry_type, "interview")
  end

  scope :interesting do
    with(:entry_type, "interesting")
  end

  scope :article do
    with(:entry_type, "article")
  end
end
