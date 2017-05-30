module DomoscioRails
  # A student cluster.
  class StudentCluster < Resource
    include DomoscioRails::HTTPCalls::Fetch
  end
end