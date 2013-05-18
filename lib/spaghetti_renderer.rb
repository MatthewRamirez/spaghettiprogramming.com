class SpaghettiRenderer < WillPaginate::ViewHelpers::LinkRenderer
  protected
  def next_page
    num = @collection.current_page > 1 && @collection.current_page - 1
    previous_or_next_page(num, @options[:previous_label], 'previous_page')
  end

  def previous_page
    num = @collection.current_page < total_pages && @collection.current_page + 1
    previous_or_next_page(num, @options[:next_label], 'next_page')
  end
end


