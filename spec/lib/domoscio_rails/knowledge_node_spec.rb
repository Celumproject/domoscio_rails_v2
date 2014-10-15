require_relative '../../spec_helper'

describe DomoscioRails::KnowledgeNode do
  include_context 'knowledge_nodes'

  created_knowledge_node_source = nil
  created_knowledge_node_destination = nil

  describe 'CREATE' do
    it 'creates a new knowledge_node to the company' do
      created_knowledge_node_source = new_knowledge_node_source
      created_knowledge_node_destination = new_knowledge_node_destination
      
      expect(created_knowledge_node_source["name"]).to eq('La prise de la Bastille')
      expect(created_knowledge_node_destination["name"]).to eq('Le jeu de Paumes')
    end
  end

  describe 'FETCH' do
    it 'fetches all the knowledge_nodes of the company' do
      knowledge_nodes = DomoscioRails::KnowledgeNode.fetch()
      expect(knowledge_nodes).to be_kind_of(Array)
      expect(knowledge_nodes.map{|kg| kg["name"]}).to include(created_knowledge_node_source["name"])
      expect(knowledge_nodes.map{|kg| kg["name"]}).to include(created_knowledge_node_destination["name"])
      expect(knowledge_nodes).not_to be_empty
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created knowledge_node of the company' do
      DomoscioRails::KnowledgeNode.destroy(created_knowledge_node_source["id"])
      DomoscioRails::KnowledgeNode.destroy(created_knowledge_node_destination["id"])
    end
  end

  describe 'FETCH' do
    it 'fetches all the knowledge_nodes of the company and checks the destroyed node is not present' do
      knowledge_nodes = DomoscioRails::KnowledgeNode.fetch()
      expect(knowledge_nodes).to be_kind_of(Array)
      expect(knowledge_nodes.map{|kg| kg["id"]}).not_to include(created_knowledge_node_source["id"])
      expect(knowledge_nodes.map{|kg| kg["id"]}).not_to include(created_knowledge_node_destination["id"])
    end
  end

  describe 'DESTROY' do
    it 'destroys the created containing knowledge_graph of the company' do
      DomoscioRails::KnowledgeGraph.destroy(created_knowledge_node_source["knowledge_graph_id"])
    end
  end

  describe 'DESTROY' do
    it 'fetches all the knowledge_graphs of the company and checks the destroyed one is not present' do
      knowledge_graphs = DomoscioRails::KnowledgeGraph.fetch()
      expect(knowledge_graphs).to be_kind_of(Array)
      expect(knowledge_graphs.map{|kg| kg["id"]}).not_to include(created_knowledge_node_source["knowledge_graph_id"])
    end
  end

end