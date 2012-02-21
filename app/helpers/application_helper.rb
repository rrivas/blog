module ApplicationHelper
  def markdown(text)
    options = [filter_html: true, autolink: true, space_after_headers: true, fenced_code_blocks: true]
    syntax_highlighter(Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(:hard_wrap => true), *options).render(text)).html_safe 
  end

  def syntax_highlighter(html)
    html = html.gsub(/\<pre\>\<code/, '<code').gsub(/\<\/code\>\<\/pre\>/, '</code>')
    doc = Nokogiri::HTML(html)
    doc.search("//code[@class]").each{ |code| code.replace(Albino.colorize(code.text.rstrip, code[:class])) }
    doc.css('body').inner_html.to_s
  end
end
