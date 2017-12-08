class CompanyRecord < ApplicationRecord
  #include Blacklight::Solr::Document
  
  after_save :index_record
  before_destroy :remove_from_index


  def to_solr
    {'id' => regno,
      'name' => name,
     'regno' => regno,
     'director_id' => director_id}
    end

  def index_record
    SolrService.add(self.to_solr)
    SolrService.commit
  end

  def remove_from_index
    SolrService.delete_by_id(self.id)
    SolrService.commit
  end
  
end
