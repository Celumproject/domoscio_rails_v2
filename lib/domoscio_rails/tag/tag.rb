module DomoscioRails
  class Tag < Resource

    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Destroy
    include DomoscioRails::HTTPCalls::Update

  end
end