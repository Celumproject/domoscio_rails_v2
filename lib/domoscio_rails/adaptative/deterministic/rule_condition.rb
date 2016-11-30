module DomoscioRails
  # A RuleCondition.
  class RuleCondition < Resource
    include DomoscioRails::HTTPCalls::Create
    include DomoscioRails::HTTPCalls::Fetch
    include DomoscioRails::HTTPCalls::Update
    include DomoscioRails::HTTPCalls::Destroy
  end
end