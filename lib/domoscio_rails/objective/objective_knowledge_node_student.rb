module DomoscioRails
    class ObjectiveKnowledgeNodeStudent < Resource
      include DomoscioRails::HTTPCalls::Fetch
      include DomoscioRails::HTTPCalls::Update
    end
  end