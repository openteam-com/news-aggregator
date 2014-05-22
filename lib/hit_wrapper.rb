class HitWrapper
  attr_accessor :hit

  def initialize(hit)
    @hit = hit
  end

  def title
    highlights_for_title = hit.highlights(:title)

    highlights_for_title.any? ?
      highlights_for_title.map { |h| h.format { |w| "<em>#{w}</em>"  } }.join :
      result.title
  end


  def result
    hit.result
  end

  def to_partial_path
    self.class.name.underscore
  end
end
