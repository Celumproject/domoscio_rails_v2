module DomoscioRails
  # A LearningPath.
  class LearningPath < Resource
    include DomoscioRails::HTTPCalls::Fetch
  end
end