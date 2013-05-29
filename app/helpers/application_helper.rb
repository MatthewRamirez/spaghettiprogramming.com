module ApplicationHelper
  include SpaghettiPagination
  # change the default link renderer for will_paginate
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => SpaghettiRenderer
    end
    super *[collection_or_options, options].compact
  end

  def categories
    @categories ||= Category.all
  end

  def parse_date_from_params(type,hash)
    "#{hash["#{type}(1i)"]}-#{hash["#{type}(2i)"]}-#{hash["#{type}(3i)"]}" <<
    " 00:00:00"
    #" #{hash["#{type}(4i)"]}:#{hash["#{type}(5i)"]}:00"
  end

  def redirect_to_root_unless_signed_in
    redirect_to root_path and return unless signed_in?
  end

  def title
    base_title = "spaghettiprogramming.com"
    return @title.nil? ? base_title : "#{base_title} | #{@title}"
  end

  def new_random_password(string)
    Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{string}--")[0,12]
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
