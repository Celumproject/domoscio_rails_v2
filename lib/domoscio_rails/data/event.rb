module DomoscioRails
  # A Student Result on a KnowledgeNode.
  class Event < Resource
    
    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Destroy

  end
end