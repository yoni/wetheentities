require 'we_the_people'

class Petition

  attr_accessor :id

  def self.find(id)
    petition = WeThePeople::Resources::Petition.find(id)
    title_and_body = "<html><title>#{petition.title}<title><body>#{petition.body}</body></html>"
    open_calais_result = OpenCalaisHelper.enhance title_and_body
    semantria_result = SemantriaHelper.enhance [{:id => petition.id, :text => title_and_body}]
    {
        :id => petition.id,
        :petition => petition,
        :open_calais => open_calais_result,
        :semantria => semantria_result
    }
  end

end
