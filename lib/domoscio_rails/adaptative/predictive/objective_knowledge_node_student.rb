module DomoscioRails
    # An objective knowledge node student.
    class ObjectiveKnowledgeNodeStudent < Resource
      include DomoscioRails::HTTPCalls::Fetch
      include DomoscioRails::HTTPCalls::Update
    end
  end
