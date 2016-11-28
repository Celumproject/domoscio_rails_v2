require_relative '../../spec_helper'

describe DomoscioRails::PathRule do
  include_context 'rule_components'
  

  created_rule_input = nil
  created_rule_output = nil
  created_rule_condition = nil
  
  created_rule_input_tagging = nil
  created_rule_input_tag = nil
  
  created_rule_output_tagging = nil
  created_rule_output_tag = nil
  
  created_path_rule = nil
  
  created_knowledge_node_source = nil 
  created_knowledge_node_destination = nil 
  created_tagging_source = nil
  created_tagging_destination = nil 
  
  created_student = nil 
  created_knowledge_node_student = nil
  created_result_success = nil
  
  recommendations = nil
  rec = nil
  
  created_tag = DomoscioRails::Tag.create({name: "Exercice"})
  created_tag_2 = DomoscioRails::Tag.create({name: "Difficulté 1"})
  
  
  describe 'CREATE' do
    it 'creates the new rule components to the company' do
      created_rule_input = new_rule_input
      created_rule_output = new_rule_output
      created_rule_condition = new_rule_condition

      expect(created_rule_input["path_rule_id"]).to eq(created_rule_output["path_rule_id"])
      expect(created_rule_output["path_rule_id"]).to eq(created_rule_condition["path_rule_id"])
    end
  end
  
  describe 'CREATE' do
    it 'creates the new rule components taggings to the company' do
      created_rule_input_tagging = DomoscioRails::Tagging.create({tag_id: created_tag["id"], taggable_id: created_rule_input["id"], taggable_type: "RuleInput"})
      created_rule_output_tagging = DomoscioRails::Tagging.create({tag_id: created_tag["id"], taggable_id: created_rule_output["id"], taggable_type: "RuleOutput"})

      expect(created_rule_input_tagging["taggable_id"]).to eq(created_rule_input["id"])
      expect(created_rule_input_tagging["taggable_type"]).to eq("RuleInput")
      expect(created_rule_output_tagging["taggable_id"]).to eq(created_rule_output["id"])
      expect(created_rule_output_tagging["taggable_type"]).to eq("RuleOutput")
      
      created_rule_input_tag = DomoscioRails::Tag.fetch(created_rule_input_tagging["tag_id"])
      created_rule_output_tag = DomoscioRails::Tag.fetch(created_rule_output_tagging["tag_id"])
      
      expect(created_rule_input_tag["name"]).to eq("Exercice")
      expect(created_rule_output_tag["name"]).to eq("Exercice")

      expect(created_rule_output_tag["id"]).to eq(created_rule_output_tag["id"])
      
    end
  end


 
  describe 'CREATE' do
    it 'creates the new knowledge_nodes and taggings to the company' do
      created_knowledge_node_source = new_knowledge_node_source
      created_knowledge_node_destination = new_knowledge_node_destination
      
      #puts created_knowledge_node_source
      
      
      created_tagging_source = DomoscioRails::Tagging.create({tag_id: created_tag["id"], taggable_id: created_knowledge_node_source["id"], taggable_type: "KnowledgeNode"})
      created_tagging_destination = DomoscioRails::Tagging.create({tag_id: created_tag["id"], taggable_id: created_knowledge_node_destination["id"], taggable_type: "KnowledgeNode"})
    end
  end
  
  describe 'CREATE' do
    it 'creates the new students and knowledge_node_students to the company' do
      created_student = new_student
      created_knowledge_node_student = DomoscioRails::KnowledgeNodeStudent.create({
      student_id: new_student["id"],
      knowledge_node_id: created_knowledge_node_source["id"]
    })
      created_result_success = DomoscioRails::Event.create({
      :knowledge_node_student_id => created_knowledge_node_student["id"],
      :type => "EventResult",
      :payload => "100"
    })
    end
  end  
  
  describe 'Fectch REcommandation' do
    it 'checks if the new recommendantion as been properly created' do
    
      recommendations = DomoscioRails::Recommendation.fetch()
    
      rec = recommendations.last
      expect(rec["rule_input_id"]).to eq(created_rule_input["id"])
      expect(rec["knowledge_node_destination"]).to eq(created_knowledge_node_destination["id"])
      
      DomoscioRails::Recommendation.destroy(rec["id"])
      
    end
    
  end
  
  describe 'Complex Recommendation' do
    it 'creates more complex taggings and several knowledge nodes to prioritize recommandation' do

      created_knowledge_node_destination_2 = new_knowledge_node_destination_2
      created_tagging_destination_2_1 = DomoscioRails::Tagging.create({tag_id: created_tag["id"], taggable_id: created_knowledge_node_destination_2["id"], taggable_type: "KnowledgeNode"})
      created_tagging_destination_2_2 = DomoscioRails::Tagging.create({tag_id: created_tag_2["id"], taggable_id: created_knowledge_node_destination_2["id"], taggable_type: "KnowledgeNode"})

      created_result_success_2 = DomoscioRails::Event.create({
      :knowledge_node_student_id => created_knowledge_node_student["id"],
      :type => "EventResult",
      :payload => "100"
    })
    end
  end

  describe 'Fectch REcommandation' do
    it 'checks if the new recommendantion as been properly created' do

      recommendations = DomoscioRails::Recommendation.fetch()
      puts recommendations.inspect

      recommendations.each do |rec|
        #puts rec
        expect(rec["rule_input_id"]).to eq(created_rule_input["id"])
        #expect(rec["knowledge_node_destination"]).to eq(created_knowledge_node_destination["id"])

        puts DomoscioRails::KnowledgeNode.fetch

        DomoscioRails::Recommendation.destroy(rec["id"])
      end

    end

  end
  
  describe 'DESTROY' do
    it 'destroys all the related and created objects' do
    
      DomoscioRails::Tag.destroy(created_tag["id"])
      DomoscioRails::KnowledgeNode.destroy(created_knowledge_node_source["id"])      
      DomoscioRails::KnowledgeNode.destroy(created_knowledge_node_destination["id"]) 
      DomoscioRails::KnowledgeNodeStudent.destroy(created_knowledge_node_student["id"])
      DomoscioRails::Student.destroy(created_student["id"])
      DomoscioRails::Event.destroy(created_result_success["id"])
          
    end
    
  end
  
  describe 'DESTROY' do
    it 'checks all the objects have properly been destroyed' do
    
      expect(DomoscioRails::Tag.fetch).to be_empty
      #expect(DomoscioRails::KnowledgeNode.fetch).to be_empty
      expect(DomoscioRails::Recommendation.fetch).to be_empty
      #expect(DomoscioRails::KnowledgeNodeStudent.fetch).to be_empty
      #expect(DomoscioRails::Student.fetch).to be_empty
      #expect(DomoscioRails::Event.fetch).to be_empty
          
    end
    
  end
  
end