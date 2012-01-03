module ApplicationHelper
  def markdown(text)
    # syntax_highlighter(Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options).render(text)).html_safe
    # syntax_highlighter(text).html_safe
    options = [filter_html: true, autolink: true, space_after_headers: true, fenced_code_blocks: true]
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :hard_wrap => true).render(text).html_safe
    syntax_highlighter(Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(:hard_wrap => true), *options).render(text)).html_safe
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//code[@class]").each{ |code| code.replace(Albino.colorize(code.text.rstrip, code[:class])) }
    doc.css('body').inner_html.to_s
  end
end
