require 'spec_helper'

describe Message do
  context 'validations' do 
    it {should validate_presence_of :name}
    it {should validate_presence_of :message}
    it {should allow_mass_assignment_of :name}
    it {should allow_mass_assignment_of :message}
  end
end