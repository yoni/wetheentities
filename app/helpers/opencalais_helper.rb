require 'calais'

module OpencalaisHelper
  def enhance(content)
    Calais.enlighten(
        :content => content,
        :content_type => :raw,
        :license_id => ENV['OPEN_CALAIS_LICENSE_ID']
    )
  end
  module_function :enhance
end
