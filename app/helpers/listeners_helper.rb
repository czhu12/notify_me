module ListenersHelper
  def relevant_texts(text, query)
    matched_query_segment = Listener.matches_query?(text, query)
    segments = matched_query_segment.split('|')
    indexes = segments.map { |segment| text.downcase.index(segment) }
    # 20 characters before, 20 characters after
    index_ranges = indexes.zip(segments).map do |index, segment|
      s = [index - 40, 0].max
      e = [index + segment.size + 40, text.size].min
      [s, e]
    end
    
    texts = index_ranges.map do |range|
      candidate_text = text[range[0]..range[1]].gsub("\n", ' ').squeeze(' ')
      first_whitespace = candidate_text.index(/\s/) || 0
      reversed = candidate_text.reverse
      last_whitespace = candidate_text.size - (reversed.index(/\w/) || 0)
      candidate_text[first_whitespace..last_whitespace].strip
    end

    final_text = texts.join('...')
    final_text = "...#{final_text}" if indexes.first != 0

    final_text = "#{final_text}..." if indexes.last != text.size - 1
    "\"#{final_text}\""
  end

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
