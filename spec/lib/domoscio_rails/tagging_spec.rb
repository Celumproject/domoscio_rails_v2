require_relative '../../spec_helper'

describe DomoscioRails::Tagging do
  include_context 'taggings'

  created = nil
  related_tag = nil
  related_kn = nil

  describe 'CREATE' do
    it 'creates a new tagging to the company' do
      created = new_tagging
      puts created.inspect
      related_tag = DomoscioRails::Tag.fetch(created["tag_id"])
      related_kn = DomoscioRails::KnowledgeNode.fetch(created["taggable_id"])
      expect(related_tag["name"]).to eq('Exercice')
      expect(related_kn["name"]).to eq('La prise de la Bastille')
    end
  end

  describe 'FETCH' do
    it 'fetches all the taggings of the company' do
      taggings = DomoscioRails::Tagging.fetch()
      expect(taggings).to be_kind_of(Array)
      expect(taggings.map{|kg| kg["id"]}).to include(created["id"])
      expect(taggings).not_to be_empty
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created tagging of the company' do
      DomoscioRails::Tagging.destroy(created["id"])
    end
  end

  describe 'FETCH' do
    it 'fetches all the taggings of the company and checks the destroyed student is not present' do
      taggings = DomoscioRails::Tagging.fetch()
      expect(taggings).to be_kind_of(Array)
      expect(taggings.map{|kg| kg["id"]}).not_to include(created["id"])
    end
  end
  
  describe 'DESTROY RELATED OBJECT' do
    it 'destroys the created tagging related objects' do
      DomoscioRails::Tag.destroy(related_tag["id"])
      DomoscioRails::KnowledgeNode.destroy(related_kn["id"])
    end
  end
  
end
