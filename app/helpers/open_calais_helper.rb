require 'calais'

module OpenCalaisHelper
  LICENSE_ID = ENV['OPEN_CALAIS_LICENSE_ID']

  def enhance(content)
    result = Calais.enlighten(
        :content => content,
        :content_type => :raw,
        :output_format => :json,
        :license_id => LICENSE_ID
    )
    ActiveSupport::JSON.decode result
  end
  module_function :enhance
end
