require_relative '../../spec_helper'

describe DomoscioRails::ReviewUtil do
  include_context 'review_utils'
  
  created_success = nil
  
  updated_knowledge_node_with_next_review_at = nil  
  
  created_knowledge_node_student_from_success = nil
  created_knowledge_node_from_success = nil
  created_knowledge_graph_from_success =  nil
  created_student_from_success = nil

  created_knowledge_node_student = nil
  created_knowledge_node = nil
  created_knowledge_graph =  nil
  created_student = nil
  
  describe 'CREATE' do
    it 'creates a new knowledge_node_student and student to the company' do
      created_student = new_student
      created_knowledge_node_student = new_knowledge_node_student
      #created_knowledge_node_student_with_next_review_at = new_knowledge_node_student_with_next_review_at
    end
  end
  
  describe 'FETCH' do
    it 'fetches all the reviews of a user' do
      reviews = DomoscioRails::ReviewUtil.util(nil, "fetch_reviews", student_id: created_student["id"].to_s)
      expect(reviews).to be_kind_of(Array)
      
      expect(reviews).not_to include(created_knowledge_node_student)
      
      
      DomoscioRails::KnowledgeNodeStudent.update(created_knowledge_node_student["id"], {next_review_at: DateTime.now})
      updated_knowledge_node_student_with_next_review_at = DomoscioRails::KnowledgeNodeStudent.fetch(created_knowledge_node_student["id"])
      
      reviews = DomoscioRails::ReviewUtil.util(nil, "fetch_reviews", student_id: created_student["id"].to_s)
      expect(reviews.map{|rev| rev["id"]}).to include(updated_knowledge_node_student_with_next_review_at["id"])
            
      pending_reviews = DomoscioRails::ReviewUtil.util(nil, "fetch_reviews", student_id: created_student["id"].to_s, :pending => true)
      expect(pending_reviews.map{|rev| rev["id"]}).to include(updated_knowledge_node_student_with_next_review_at["id"])
      
      pending_reviews.each do |rev|
        expect(rev["next_review_at"]).to be < DateTime.now
      end
    end
  end
  
  describe 'FETCH_ASSOCIATED_MODELS' do
    it 'fetches the associated models to the newly created knowledge_node_student' do
      created_knowledge_node = DomoscioRails::KnowledgeNode.fetch(created_knowledge_node_student["knowledge_node_id"])
      created_knowledge_graph = DomoscioRails::KnowledgeGraph.fetch(created_knowledge_node["knowledge_graph_id"])
      created_student = DomoscioRails::Student.fetch(created_knowledge_node_student["student_id"]).first
      
    end
  end

  describe 'CREATE' do
    it 'creates a new result to the knowledge_node_student' do
      created_success = new_result_success
      created_knowledge_node_student_from_success = DomoscioRails::KnowledgeNodeStudent.fetch(created_success["knowledge_node_student_id"])
    end
  end

  describe 'FETCH' do
    it 'fetches all the reviews of a user' do
      
      reviews = DomoscioRails::ReviewUtil.util(nil, "fetch_reviews", student_id: created_knowledge_node_student_from_success["student_id"].to_s).map{|rev| rev["id"]}
      expect(reviews).to be_kind_of(Array)
      
      expect(reviews).to include(created_knowledge_node_student_from_success["id"])
            
      pending_reviews = DomoscioRails::ReviewUtil.util(nil, "fetch_reviews", student_id: created_knowledge_node_student_from_success["student_id"].to_s, :pending => true).map{|rev| rev["id"]}
      expect(pending_reviews).not_to include(created_knowledge_node_student_from_success["id"])
      
    end
  end

  describe 'DESTROY' do
    it 'destroys the created results of the company' do
      DomoscioRails::Event.destroy(created_success["id"])
    end
  end

  describe 'FETCH_ASSOCIATED_MODELS' do
    it 'fetches the associated models to the newly created result' do
      created_knowledge_node_from_success = DomoscioRails::KnowledgeNode.fetch(created_knowledge_node_student_from_success["knowledge_node_id"])
      created_knowledge_graph_from_success = DomoscioRails::KnowledgeGraph.fetch(created_knowledge_node_from_success["knowledge_graph_id"])
      created_student_from_success = DomoscioRails::Student.fetch(created_knowledge_node_student_from_success["student_id"]).first
    end
  end

  describe 'DESTROY_ASSOCIATED_MODELS' do
    it 'destroys all the associated models to the student of the company and checks the destroyed ones are no longer present in DB' do
      DomoscioRails::KnowledgeNodeStudent.destroy(created_knowledge_node_student["id"])
      DomoscioRails::KnowledgeNode.destroy(created_knowledge_node["id"])
      DomoscioRails::KnowledgeGraph.destroy(created_knowledge_graph["id"])
      DomoscioRails::Student.destroy(created_student["id"])
      
      DomoscioRails::KnowledgeNodeStudent.destroy(created_knowledge_node_student_from_success["id"])
      DomoscioRails::KnowledgeNode.destroy(created_knowledge_node_from_success["id"])
      DomoscioRails::KnowledgeGraph.destroy(created_knowledge_graph_from_success["id"])
      DomoscioRails::Student.destroy(created_student_from_success["id"])
      
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