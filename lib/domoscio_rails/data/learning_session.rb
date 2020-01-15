module DomoscioRails
  # A LearningSession is basicly a group of events.
  class LearningSession < Resource
    
    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Destroy

  end
end