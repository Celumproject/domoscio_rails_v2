module DomoscioRails
  class Event < Resource
    
    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Destroy

  end
end