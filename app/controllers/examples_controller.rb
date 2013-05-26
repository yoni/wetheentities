class ExamplesController < ApplicationController
  def index
  end
  def sentiment
    @js_source = 'example_javascripts/sentiment.js'
    js_file_path = Rails.root.join('public', @js_source)
    @javascript_highlighted = CodeRay.scan(File.read(js_file_path), :javascript).div

    @html_source = 'example_htmls/sentiment.html'
    html_file_path = Rails.root.join('public', @html_source)
    @html = File.read(html_file_path)
    @html_highlighted = CodeRay.scan(@html, :html).div
  end
  def geo
  end
end
