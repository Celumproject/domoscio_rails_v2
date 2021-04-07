module DomoscioRails
  class Content < Resource

    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Update
    include DomoscioRails::HTTPCalls::Destroy
    include DomoscioRails::HTTPCalls::Util

  end
end