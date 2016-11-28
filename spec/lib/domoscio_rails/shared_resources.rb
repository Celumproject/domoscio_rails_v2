
###############################################
shared_context 'users' do
###############################################

  let(:new_user) {
    DomoscioRails::User.create({
      name: 'John'
    })
  }


end


###############################################
shared_context 'students' do
###############################################

  let(:new_student) {
    DomoscioRails::Student.create({
      civil_profile_attributes: {
        name: "Student1",
        sexe: "male",
        date_of_birth: Date.today,
        place_of_birth: "FR",
        country_of_residence: "FR",
        city_of_residence: "Paris"
      }
    })
  }


end


###############################################
shared_context 'knowledge_graphs' do
###############################################

  let(:new_knowledge_graph) {
    DomoscioRails::KnowledgeGraph.create({
      name: 'La révolution Française'
    })
  }


end


###############################################
shared_context 'knowledge_nodes' do
###############################################
  include_context 'knowledge_graphs'


  let(:new_knowledge_node_source) {
    DomoscioRails::KnowledgeNode.create({
      knowledge_graph_id: new_knowledge_graph["id"],
      name: 'La prise de la Bastille'
    })
  }
  let(:new_knowledge_node_destination) {
    DomoscioRails::KnowledgeNode.create({
      knowledge_graph_id: new_knowledge_graph["id"],
      name: 'Le jeu de Paumes'
    })
  }

end


###############################################
shared_context 'knowledge_edges' do
###############################################
  include_context 'knowledge_graphs'
  include_context 'knowledge_nodes'


  let(:new_knowledge_edge) {
    DomoscioRails::KnowledgeEdge.create({
      knowledge_graph_id: new_knowledge_graph["id"],
      source_node_id: new_knowledge_node_source["id"],
      destination_node_id: new_knowledge_node_destination["id"]
    })
  }


end

###############################################
shared_context 'knowledge_node_students' do
###############################################
  include_context 'knowledge_nodes'
  include_context 'students'


  let(:new_knowledge_node_student) {
    DomoscioRails::KnowledgeNodeStudent.create({
      student_id: new_student["id"],
      knowledge_node_id: new_knowledge_node_source["id"]
    })
  }
  
  let(:new_knowledge_node_student_with_next_review_at) {
    DomoscioRails::KnowledgeNodeStudent.create({
      student_id: new_student["id"],
      knowledge_node_id: new_knowledge_node_source["id"],
      next_review_at: DateTime.now
    })
  }

end

###############################################
shared_context 'events' do
###############################################
  include_context 'knowledge_node_students'


  let(:new_result_success) {
    DomoscioRails::Event.create({
      :knowledge_node_student_id => new_knowledge_node_student["id"],
      :type => "EventResult",
      :payload => "100"
    })
  }
  
  let(:new_result_failure) {
    DomoscioRails::Event.create({
      :knowledge_node_student_id => new_knowledge_node_student["id"],
      :type => "EventResult",
      :payload => "0"
    })
  }
  
  let(:new_result_scd_success) {
    DomoscioRails::Event.create({
      :knowledge_node_student_id => new_knowledge_node_student["id"],
      :type => "EventResult",
      :payload => "100"
    })
  }
  
  let(:new_result_thrd_success_no_response) {
    DomoscioRails::Event.create({
      :knowledge_node_student_id => new_knowledge_node_student["id"],
      :type => "EventResult",
      :payload => "100",
      :no_response => true
    })
  }

end

###############################################
shared_context 'review_utils' do
###############################################
  include_context 'knowledge_node_students'
  include_context 'events'

end

shared_context 'tag_sets' do
###############################################
 
  let(:new_tag_set) {
    DomoscioRails::TagSet.create({
      name: "Attributs"
    })
  }
  
  
end

shared_context 'tags' do
###############################################
  include_context 'tag_sets'
  
  let(:new_tag) {
    DomoscioRails::Tag.create({
      tag_set_id: new_tag_set["id"],
      name: "Exercice"
    })
  }

end

shared_context 'taggings' do
###############################################
  include_context 'knowledge_nodes'
  include_context 'tag_sets'
  include_context 'tags'

  let(:new_tagging) {
    DomoscioRails::Tagging.create({
      tag_id: new_tag["id"],
      taggable_type: "KnowledgeNode",
      taggable_id: new_knowledge_node_source["id"]
    })
  }
end

shared_context 'path_rules' do
###############################################


  let(:new_path_rule) {
    DomoscioRails::PathRule.create({
      type: "RemediationRule",
      active: true,
      priority: 0
    })
  }
end

shared_context 'rule_components' do
###############################################
  include_context 'path_rules'

  let(:new_rule_input) {
    DomoscioRails::RuleInput.create({
      path_rule_id: new_path_rule["id"]
    })
  }
  let(:new_rule_condition) {
    DomoscioRails::RuleCondition.create({
      path_rule_id: new_path_rule["id"],
      content: '
          [
              {
                  "type": "Condition",
                  "value": {
                      "Attribute": {
                        "type": "EventField",
                        "value": "result"
                      },
                      "ConstantValue": {
                        "type": "Integer",
                        "value": "1"
                      },
                      "MathematicalOperator": {
                          "type": "Equal"
                      }
                  }
              }
          ]
          '
    })
  }
  let(:new_rule_output) {
    DomoscioRails::RuleOutput.create({
      path_rule_id: new_path_rule["id"]
    })
  }
  let(:new_tagging_rule_input) {
    DomoscioRails::Tagging.create({
      tag_id: new_tag["id"],
      taggable_type: "RuleInput",
      taggable_id: new_rule_input["id"]
    })
  }
  let(:new_tagging_rule_output) {
    DomoscioRails::Tagging.create({
      tag_id: new_tag["id"],
      taggable_type: "RuleOutput",
      taggable_id: new_rule_output["id"]
    })
  }
  
  let(:new_student) {
    DomoscioRails::Student.create({
      civil_profile_attributes: {
        name: "Student_Rule",
        sexe: "male",
        date_of_birth: Date.today,
        place_of_birth: "FR",
        country_of_residence: "FR",
        city_of_residence: "Paris"
      }
    })
  }
  
  let(:new_knowledge_node_source) {
    DomoscioRails::KnowledgeNode.create({
      knowledge_graph_id: nil,
      name: 'Exercice -- La prise de la Bastille'
    })
  }
  
  let(:new_knowledge_node_destination) {
    DomoscioRails::KnowledgeNode.create({
      knowledge_graph_id: nil,
      name: 'Exercice -- Le jeu de Paumes'
    })
  }
  
  let(:new_knowledge_node_destination_2) {
    DomoscioRails::KnowledgeNode.create({
      knowledge_graph_id: nil,
      name: 'Exercice -- Difficulté 1 -- Robespierre'
    })
  }
  
  let(:new_tagging_source) {
    DomoscioRails::Tagging.create({
      tag_id: new_tag["id"],
      taggable_type: "KnowledgeNode",
      taggable_id: new_knowledge_node_source["id"]
    })
  }
  
  let(:new_tagging_destination) {
    DomoscioRails::Tagging.create({
      tag_id: new_tag["id"],
      taggable_type: "KnowledgeNode",
      taggable_id: new_knowledge_node_destination["id"]
    })
  }
 
  
end