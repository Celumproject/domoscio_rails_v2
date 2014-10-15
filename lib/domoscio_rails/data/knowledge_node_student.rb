module DomoscioRails
  # A Knowledge Edge.
  class KnowledgeNodeStudent < Resource
    
    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Destroy

  end
end