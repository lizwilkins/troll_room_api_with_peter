require 'spec_helper'

describe RoomsController do

  context 'routing' do
    it {should route(:post, '/rooms').to :action => :create}
    it {should route(:get, '/rooms/1').to :action => :show, :id => 1}
    it {should route(:get, '/rooms').to :action => :index}
    it {should route(:get, '/messages').to :action => :list_messages}
  end

  context 'POST create' do
    context 'with valid parameters' do
      let(:valid_attributes) {{:name => 'trolly chat room'}}
      let(:valid_parameters) {{:room => valid_attributes}}

      it 'creates a new message' do
        expect {post :create, valid_parameters}.to change(Room, :count).by(1)
      end

      before {post :create, valid_parameters}

      it {should respond_with 201}
      it {should respond_with_content_type :json}
      it 'responds with a json representation of the newly-created room' do
        response.body.should eq Room.find(JSON.parse(response.body)['room']['id']).to_json
      end      
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) {{:name => ''}}
      let(:invalid_parameters) {{:room => invalid_attributes}}

      before {post :create, invalid_parameters}

      it {should respond_with 422}
      it {should respond_with_content_type :json}
      it 'responds with a json representation of the errors' do
        response.body.should eq Room.create(invalid_attributes).errors.to_json
      end
    end
  end

  context 'GET index' do
    let(:parameters) {{:limit => 20}}
    before {21.times {|num| Room.create({:name => "name#{num}"})}}
    before {get :index, parameters}


    it {should respond_with 200}
    it {should respond_with_content_type :json}
    it 'responds with a json representation of the last 20 chat rooms' do
      response.body.should eq Room.limit(20).to_json
    end
  end

  context 'GET show' do
    let(:room) {FactoryGirl.create :room}
    before {get :show, :id => room.id}

    it {should respond_with 200}
    it {should respond_with_content_type :json}
    it 'responds with a json representation of the room' do
      response.body.should eq room.to_json
    end
  end

  context 'GET list_messages' do
    context 'limit to 20 messages' do
      let(:room) {FactoryGirl.create :room}
      let(:parameters) {{:limit => 20, :room_id => 1}}
      before {21.times {|num| Message.create({:name => "name#{num}", :message => "msg#{num}", :room_id => 1})}}     
      before {get :list_messages, parameters}

      it {should respond_with 200}
      it {should respond_with_content_type :json}
      it 'responds with a json representation of the last 20 messages' do
        response.body.should eq Message.limit(20).to_json
      end
    end
  end


end