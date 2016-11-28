require_relative '../../spec_helper'

describe DomoscioRails::PathRule do
  include_context 'path_rules'
  

  created = nil

  describe 'CREATE' do
    it 'creates a new path_rule to the company' do
      created = new_path_rule
      expect(created["type"]).to eq('RemediationRule')
    end
  end

  describe 'FETCH' do
    it 'fetches all the path_rules of the company' do
      path_rules = DomoscioRails::PathRule.fetch()
      expect(path_rules).to be_kind_of(Array)
      expect(path_rules.map{|kg| kg["id"]}).to include(created["id"])
      expect(path_rules).not_to be_empty
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created path_rule of the company' do
      DomoscioRails::PathRule.destroy(created["id"])
    end
  end

  describe 'FETCH' do
    it 'fetches all the path_rules of the company and checks the destroyed path_rule is not present' do
      path_rules = DomoscioRails::PathRule.fetch()
      expect(path_rules).to be_kind_of(Array)
      expect(path_rules.map{|kg| kg["id"]}).not_to include(created["id"])
    end
  end
  
  
  
end