require 'calais'

module OpencalaisHelper
  LICENSE_ID = ENV['OPEN_CALAIS_LICENSE_ID']

  def enhance(content)
    Calais.enlighten(
        :content => content,
        :content_type => :html,
        :license_id => LICENSE_ID
    )
  end
  module_function :enhance
end
