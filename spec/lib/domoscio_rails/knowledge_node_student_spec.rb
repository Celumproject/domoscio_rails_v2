require_relative '../../spec_helper'

describe DomoscioRails::KnowledgeNodeStudent do
  include_context 'knowledge_node_students'
  
  created = nil
  created_knowledge_node = nil

  describe 'CREATE' do
    it 'creates a new knowledge_node_student to the company' do
      created = new_knowledge_node_student
      expect(created["id"]).to be_kind_of(Integer)
      expect(created["student_id"]).to be_kind_of(Integer)
      expect(created["knowledge_node_id"]).to be_kind_of(Integer)
    end
  end

  describe 'FETCH' do
    it 'fetches all the knowledge_node_students of the company' do
      knowledge_node_students = DomoscioRails::KnowledgeNodeStudent.fetch()
      expect(knowledge_node_students).to be_kind_of(Array)
      expect(knowledge_node_students.map{|kns| kns["id"]}).to include(created["id"])
      expect(knowledge_node_students).not_to be_empty
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created knowledge_node_student of the company' do
      DomoscioRails::KnowledgeNodeStudent.destroy(created["id"])
    end
  end

  describe 'FETCH' do
    it 'fetches all the knowledge_node_students of the company and checks the destroyed one is not present' do
      knowledge_node_students = DomoscioRails::KnowledgeNodeStudent.fetch()
      expect(knowledge_node_students).to be_kind_of(Array)
      expect(knowledge_node_students.map{|kns| kns["id"]}).not_to include(created["id"])
    end
  end

  describe 'DESTROY_STUDENT' do
    it 'destroys the created student of the company' do
      DomoscioRails::Student.destroy(created["student_id"])
    end
  end

  describe 'FETCH_STUDENT' do
    it 'fetches all the students of the company and checks the destroyed one is not present' do
      students = DomoscioRails::Student.fetch()
      expect(students).to be_kind_of(Array)
      expect(students.map{|s| s["id"]}).not_to include(created["student_id"])
    end
  end  

  describe 'FETCH_KNOWLEDGE_NODE' do
    it 'fetches then newly created student to the company' do
      created_knowledge_node = DomoscioRails::KnowledgeNode.fetch(created["knowledge_node_id"])
      #pp created_knowledge_node
      expect(created_knowledge_node["id"]).to be_kind_of(Integer)
    end
  end

  describe 'DESTROY_KNOWLEDGE_NODE' do
    it 'destroys the created knowledge_node of the company' do
      DomoscioRails::KnowledgeNode.destroy(created_knowledge_node["id"])
    end
  end

  describe 'FETCH_KNOWLEDGE_NODES' do
    it 'fetches all the knowledge_nodes of the company and checks the destroyed one is not present' do
      knowledge_nodes = DomoscioRails::KnowledgeNode.fetch()
      expect(knowledge_nodes).to be_kind_of(Array)
      expect(knowledge_nodes.map{|s| s["id"]}).not_to include(created_knowledge_node["id"])
    end
  end  
  
  describe 'DESTROY_KNOWLEDGE_GRAPH' do
    it 'destroys the created knowledge_graph of the company' do
      DomoscioRails::KnowledgeGraph.destroy(created_knowledge_node["knowledge_graph_id"])
    end
  end

  describe 'FETCH_KNOWLEDGE_GRAPHS' do
    it 'fetches all the knowledge_graphs of the company and checks the destroyed one is not present' do
      knowledge_graphs = DomoscioRails::KnowledgeGraph.fetch()
      expect(knowledge_graphs).to be_kind_of(Array)
      expect(knowledge_graphs.map{|kg| kg["id"]}).not_to include(created_knowledge_node["knowledge_graph_id"])
    end
  end  

end