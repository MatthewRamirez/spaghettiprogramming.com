module SpaghettiPagination
  class SpaghettiRenderer < WillPaginate::ActionView::LinkRenderer
    protected
      def previous_page
        num = @collection.current_page < total_pages && @collection.current_page + 1
        previous_or_next_page(num, @options[:next_label], 'next_page')
      end

      def next_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(num, @options[:previous_label], 'previous_page')
      end

      def page_number(page)
        unless page == current_page
          tag(:li, link(page, page, :rel => rel_value(page)))
        else
          tag(:li, page, :class => "current")
        end
      end

      def previous_or_next_page(page, text, classname)
        if page
          tag(:li, link(text, page), :class => classname)
        else
          tag(:li, link(text,''), :class => classname )
        end
      end

      def html_container(html)
        tag(:ul, html, container_attributes)
      end

  end
end
