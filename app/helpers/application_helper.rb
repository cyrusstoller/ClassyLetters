module ApplicationHelper
  def title
    base_title = "Classy Lettres"
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end
end
