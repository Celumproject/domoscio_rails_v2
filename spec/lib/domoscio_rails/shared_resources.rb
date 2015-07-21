
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
shared_context 'results' do
###############################################
  include_context 'knowledge_node_students'


  let(:new_result_success) {
    DomoscioRails::Result.create({
      :knowledge_node_student_id => new_knowledge_node_student["id"],
      :value => 1
    })
  }
  
  let(:new_result_failure) {
    DomoscioRails::Result.create({
      :knowledge_node_student_id => new_knowledge_node_student["id"],
      :value => 0
    })
  }
  
  let(:new_result_scd_success) {
    DomoscioRails::Result.create({
      :knowledge_node_student_id => new_knowledge_node_student["id"],
      :value => 1
    })
  }
  
  let(:new_result_thrd_success_no_response) {
    DomoscioRails::Result.create({
      :knowledge_node_student_id => new_knowledge_node_student["id"],
      :value => 1,
      :no_response => true
    })
  }

end

###############################################
shared_context 'review_utils' do
###############################################
  include_context 'knowledge_node_students'
  include_context 'results'


end



