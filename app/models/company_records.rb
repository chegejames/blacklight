class CompanyRecord < ActiveRecord::Base
  after_save :index_record
  before_destroy :remove_from_index

  attr_accessor :name, :status, :director_id


  def to_solr
    {'id' => id,
     'name_s' => name,
     'status_s' => status,
     'director_id' => director_id
    }
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
