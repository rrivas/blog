module ApplicationHelper
  def markdown(text)
    # options = [hard_wrap: true, filter_html: true, autolink: true, no_intraemphasis: true, fenced_code_blocks: true, gh_blockcode: true]

    options = [hard_wrap: true, filter_html: true, autolink: true, space_after_headers: true, fenced_code_blocks: true]
    syntax_highlighter(Redcarpet::Markdown.new(Redcarpet::Render::HTML, *options).render(text)).html_safe
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end
end
