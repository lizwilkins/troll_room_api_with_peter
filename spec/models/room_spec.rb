require 'spec_helper'

describe Room do
  context 'validations' do 
    it {should validate_presence_of :name}
    it {should allow_mass_assignment_of :name}
  end
end