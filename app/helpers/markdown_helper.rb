module MarkdownHelper

  def mdown(text)
    return "" if text.blank?
    Kramdown::Document.new(text).to_html.html_safe
  end

end
