module DomoscioRails
  # A Recommandation.
  class Recommendation < Resource
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Destroy
  end
end