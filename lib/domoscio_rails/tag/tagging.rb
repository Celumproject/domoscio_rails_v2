module DomoscioRails
  class Tagging < Resource

    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Update
    include DomoscioRails::HTTPCalls::Destroy

  end
end