require_relative '../../spec_helper'

describe DomoscioRails::TagSet do
  include_context 'tag_sets'

  created = nil

  describe 'CREATE' do
    it 'creates a new tag_set to the company' do
      created = new_tag_set
      expect(created["name"]).to eq('Attributs')
    end
  end

  describe 'FETCH' do
    it 'fetches all the tag_sets of the company' do
      tag_sets = DomoscioRails::TagSet.fetch()
      expect(tag_sets).to be_kind_of(Array)
      expect(tag_sets.map{|kg| kg["name"]}).to include(created["name"])
      expect(tag_sets).not_to be_empty
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created knowledge_graph of the company' do
      DomoscioRails::TagSet.destroy(created["id"])
    end
  end

  describe 'FETCH' do
    it 'fetches all the knowledge_graphs of the company and checks the destroyed student is not present' do
      tag_sets = DomoscioRails::TagSet.fetch()
      expect(tag_sets).to be_kind_of(Array)
      expect(tag_sets.map{|kg| kg["id"]}).not_to include(created["id"])
    end
  end
  

  
end
