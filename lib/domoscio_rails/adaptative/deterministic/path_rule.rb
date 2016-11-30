module DomoscioRails
  # A PathRule.
  class PathRule < Resource
    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Update
    include DomoscioRails::HTTPCalls::Destroy
    include DomoscioRails::HTTPCalls::Util
  end
end