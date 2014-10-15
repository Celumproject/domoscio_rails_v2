require_relative '../../spec_helper'

describe DomoscioRails::Student do
  include_context 'students'

  created = nil

  describe 'CREATE' do
    it 'creates a new student to the company' do
      created = new_student
      expect(created["civil_profile"]["name"]).to eq('Student1')
      #pp new_student
    end
  end

  describe 'FETCH' do
    it 'fetches all the students of the company' do
      students = DomoscioRails::Student.fetch()
      #pp students
      expect(students).to be_kind_of(Array)
      expect(students.map{|u| u["civil_profile"]["name"]}).to include(created["civil_profile"]["name"])
      expect(students).not_to be_empty
    end
  end
  
  describe 'DESTROY' do
    it 'destroys the created student of the company' do
      student = DomoscioRails::Student.destroy(created["id"])
    end
  end

  describe 'FETCH' do
    it 'fetches all the students of the company and checks the destroyed student is not present' do
      students = DomoscioRails::Student.fetch()
      #pp students
      expect(students).to be_kind_of(Array)
      expect(students.map{|u| u["id"]}).not_to include(created["id"])
    end
  end

end