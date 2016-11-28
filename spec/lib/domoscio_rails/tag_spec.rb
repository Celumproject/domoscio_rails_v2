require_relative '../../spec_helper'

describe DomoscioRails::Tag do
  include_context 'tags'

  created = nil

  describe 'CREATE' do
    it 'creates a new tag to the company' do
      created = new_tag
      expect(created["name"]).to eq('Exercice')
    end
  end

  describe 'FETCH' do
    it 'fetches all the tags of the company' do
      tags = DomoscioRails::Tag.fetch()
      expect(tags).to be_kind_of(Array)
      expect(tags.map{|kg| kg["name"]}).to include(created["name"])
      expect(tags).not_to be_empty
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created tag of the company' do
      DomoscioRails::Tag.destroy(created["id"])
    end
  end

  describe 'FETCH' do
    it 'fetches all the tags of the company and checks the destroyed student is not present' do
      tags = DomoscioRails::Tag.fetch()
      expect(tags).to be_kind_of(Array)
      expect(tags.map{|kg| kg["id"]}).not_to include(created["id"])
    end
  end
  
  describe 'DESTROY RELATED TAG SET' do
    it 'destroys the created tag_set of the company' do
      DomoscioRails::TagSet.destroy(created["tag_set_id"])
    end
  end
  
  
end
