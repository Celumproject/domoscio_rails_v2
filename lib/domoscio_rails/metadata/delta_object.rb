module DomoscioRails
  # A delta object.
  class DeltaObject < Resource
    include DomoscioRails::HTTPCalls::Fetch
  end
end
