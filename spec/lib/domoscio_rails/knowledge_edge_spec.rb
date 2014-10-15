require_relative '../../spec_helper'

describe DomoscioRails::KnowledgeEdge do
  include_context 'knowledge_edges'

  created = nil

  describe 'CREATE' do
    it 'creates a new knowledge_edge to the company' do
      created = new_knowledge_edge
      expect(created["id"]).to be_kind_of(Integer)
      expect(created["destination_node_id"]).to be_kind_of(Integer)
      expect(created["source_node_id"]).to be_kind_of(Integer)

      #pp created
    end
  end

  describe 'FETCH' do
    it 'fetches all the knowledge_edges of the company' do
      knowledge_edges = DomoscioRails::KnowledgeEdge.fetch()
      #pp knowledge_edges
      #pp created
      expect(knowledge_edges).to be_kind_of(Array)
      expect(knowledge_edges.map{|kg| kg["id"]}).to include(created["id"])
      expect(knowledge_edges).not_to be_empty
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created knowledge_edge of the company' do
       DomoscioRails::KnowledgeEdge.destroy(created["id"])
    end
  end

  describe 'FETCH' do
    it 'fetches all the knowledge_edges of the company and checks the destroyed student is not present' do
      knowledge_edges = DomoscioRails::KnowledgeEdge.fetch()
      expect(knowledge_edges).to be_kind_of(Array)
      expect(knowledge_edges.map{|kg| kg["id"]}).not_to include(created["id"])
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created containing knowledge_graph of the company' do
      DomoscioRails::KnowledgeGraph.destroy(created["knowledge_graph_id"])
    end
  end
  
  describe 'DESTROY' do
    it 'fetches all the knowledge_graphs of the company and checks the destroyed one is not present' do
      knowledge_graphs = DomoscioRails::KnowledgeGraph.fetch()
      expect(knowledge_graphs).to be_kind_of(Array)
      expect(knowledge_graphs.map{|kg| kg["id"]}).not_to include(created["knowledge_graph_id"])
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created containing knowledge_graph of the company' do
      DomoscioRails::KnowledgeNode.destroy(created["destination_node_id"])
      DomoscioRails::KnowledgeNode.destroy(created["source_node_id"])
      # pp created
    end
  end
  
  describe 'DESTROY' do
    it 'fetches all the knowledge_nodes of the company and checks the destroyed ones are not present' do
      knowledge_nodes = DomoscioRails::KnowledgeNode.fetch()
      expect(knowledge_nodes).to be_kind_of(Array)
      expect(knowledge_nodes.map{|kg| kg["id"]}).not_to include(created["destination_node_id"])
      expect(knowledge_nodes.map{|kg| kg["id"]}).not_to include(created["source_node_id"])
    end
  end

end