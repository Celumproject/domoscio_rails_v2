module DomoscioRails
  # A company.
  class Company < Resource
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Update
  end
end