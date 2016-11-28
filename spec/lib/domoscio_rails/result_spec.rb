require_relative '../../spec_helper'

describe DomoscioRails::Event do
  include_context 'events'
  
  created_success = nil
  created_failure = nil

  created_success2 = nil
  created_failure2 = nil
  created_success3 = nil
  created_success_without_response = nil
  
  created_knowledge_node_student = nil
  created_knowledge_node = nil
  created_knowledge_graph =  nil
  created_student = nil
  
  next_review_at = nil
  current_review_interv = nil

  describe 'CREATE' do
    it 'creates a new result to the company' do
      created_success = new_result_success
      created_failure = new_result_failure
      expect(created_success["value"]).to eq(100)
      expect(created_failure["value"]).to eq(0)
      expect(DateTime.parse(created_success["expected_at"])).to be_kind_of(DateTime)
      expect(DateTime.parse(created_failure["expected_at"])).to be_kind_of(DateTime)
    end
  end

  describe 'FETCH' do
    it 'fetches all the results of the company' do
      results = DomoscioRails::Event.fetch()
      expect(results).to be_kind_of(Array)
      expect(results.map{|res| res["id"]}).to include(created_success["id"])
      expect(results.map{|res| res["id"]}).to include(created_failure["id"])
      expect(results).not_to be_empty
    end
  end
  
  describe 'FETCH' do
    it 'fetches the knowledge_node_student for the created result' do
      kns = DomoscioRails::KnowledgeNodeStudent.fetch(created_success["knowledge_node_student_id"])
      next_review_at = kns["next_review_at"]
      current_review_interv = kns["current_review_interv"]
      expect(kns["history"]).to eq("10")
    end
  end
  
  describe 'CREATE' do
    it 'creates a new result to the company but too soon so that intevall until next_review has not changed' do
      created_success2 = new_result_success
      created_failure2 = new_result_failure
      created_success3 = new_result_scd_success
    end
  end
  
  describe 'CREATE WITH NO RESULT' do
    it 'creates a new result expecting no_response' do
      created_success_without_response = new_result_thrd_success_no_response
      expect(created_success_without_response).to be_empty
    end
  end
  
  describe 'FETCH' do
    it 'fetches the knowledge_node_student for the created result' do
      kns = DomoscioRails::KnowledgeNodeStudent.fetch(created_success2["knowledge_node_student_id"])
      expect(kns["history"]).to eq("101")
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created results of the company' do
      DomoscioRails::Event.destroy(created_success["id"])
      DomoscioRails::Event.destroy(created_failure["id"])
      DomoscioRails::Event.destroy(created_success2["id"])
    end
  end

  describe 'FETCH' do
    it 'fetches all the results of the company and checks the destroyed results are not present' do
      results = DomoscioRails::Event.fetch()
      expect(results).to be_kind_of(Array)
      expect(results.map{|res| res["id"]}).not_to include(created_failure["id"])
      expect(results.map{|res| res["id"]}).not_to include(created_success["id"])
    end
  end
  
  describe 'FETCH_ASSOCIATED_MODELS' do
    it 'fetches the associated models to the newly created result' do
      created_knowledge_node_student = DomoscioRails::KnowledgeNodeStudent.fetch(created_failure["knowledge_node_student_id"])
      created_knowledge_node = DomoscioRails::KnowledgeNode.fetch(created_knowledge_node_student["knowledge_node_id"])
      created_knowledge_graph = DomoscioRails::KnowledgeGraph.fetch(created_knowledge_node["knowledge_graph_id"])
      created_student = DomoscioRails::Student.fetch(created_knowledge_node_student["student_id"]).first
    end
  end

  describe 'DESTROY_ASSOCIATED_MODELS' do
    it 'destroys all the associated models to the student of the company and checks the destroyed ones are no longer present in DB' do
      DomoscioRails::KnowledgeNodeStudent.destroy(created_knowledge_node_student["id"])
      DomoscioRails::KnowledgeNode.destroy(created_knowledge_node["id"])
      DomoscioRails::KnowledgeGraph.destroy(created_knowledge_graph["id"])
      puts "HERE:" + created_student.inspect
      DomoscioRails::Student.destroy(created_student["id"])
      
      kncs = DomoscioRails::KnowledgeNodeStudent.fetch()
      expect(kncs).to be_kind_of(Array)
      expect(kncs.map{|knc| knc["id"]}).not_to include(created_knowledge_node_student["id"])
      
      kns = DomoscioRails::KnowledgeNode.fetch()
      expect(kns).to be_kind_of(Array)
      expect(kns.map{|kn| kn["id"]}).not_to include(created_knowledge_node["id"])
      
      kgs = DomoscioRails::KnowledgeGraph.fetch()
      expect(kgs).to be_kind_of(Array)
      expect(kgs.map{|kg| kg["id"]}).not_to include(created_knowledge_graph["id"])
      
      students = DomoscioRails::Student.fetch()
      expect(students).to be_kind_of(Array)
      expect(students.map{|stud| stud["id"]}).not_to include(created_student["id"])
    end
  end   
  
end