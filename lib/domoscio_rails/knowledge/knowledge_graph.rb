module DomoscioRails
  # A Knowledge Graph.
  class KnowledgeGraph < Resource
    
    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Update
    include DomoscioRails::HTTPCalls::Destroy

  end
end