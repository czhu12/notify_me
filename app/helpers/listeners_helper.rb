module ListenersHelper
  def highlighted_texts(text, query)
    # TODO: This assumes query is an exact substring match.
    matched_query_segment = Listener.matches_query?(text, query)
    segments = matched_query_segment.split('|')

    starting_index = 0
    processed_texts = []
    segments.each do |segment|
      idx = text.downcase.index(segment)
      processed_texts << { :bolded => false, :text => text[starting_index..idx - 1] }
      processed_texts << { :bolded => true, :text => text[idx..(segment.size + idx)] }
      starting_index = segment.size + idx
    end
    processed_texts << { :bolded => false, :text => text[starting_index..text.size] }
    processed_texts
  end
end
