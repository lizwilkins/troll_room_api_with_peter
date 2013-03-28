FactoryGirl.define do 
  factory :message do 
    name 'michael'
    message 'tdd or the highway!'
    room_id 1
  end

  factory :room do 
    name 'Chatty Girl'
  end
end