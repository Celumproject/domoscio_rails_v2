module DomoscioRails
  class ObjectiveStudent < Resource

    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Destroy
    include DomoscioRails::HTTPCalls::Update
    include DomoscioRails::HTTPCalls::Util

  end
end
