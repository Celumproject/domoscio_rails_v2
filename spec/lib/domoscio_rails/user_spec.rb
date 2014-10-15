require_relative '../../spec_helper'

describe DomoscioRails::User do
  include_context 'users'

  describe 'CREATE' do
    it 'creates a new user to the company' do
      expect(new_user["name"]).to eq('John')
    end
  end

  describe 'FETCH' do
    it 'fetches all the users of the company' do
      users = DomoscioRails::User.fetch()
      expect(users).to be_kind_of(Array)
      expect(users.map{|u| u["name"]}).to include(new_user["name"])
      expect(users).not_to be_empty
    end
  end

end