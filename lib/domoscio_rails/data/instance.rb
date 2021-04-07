module DomoscioRails
  class Instance < Resource

    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::UpdateSelf
    include DomoscioRails::HTTPCalls::Destroy

  end
end
