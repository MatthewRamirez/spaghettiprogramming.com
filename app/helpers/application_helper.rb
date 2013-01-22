module ApplicationHelper

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
    base_title = "Customer Order App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    image_tag("weborderlogo.png", :alt => "Vision Web Order App", :class => "round")
  end

  def new_random_password(string)
    Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{string}--")[0,12]
  end

end
