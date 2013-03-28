require 'spec_helper'

describe MessagesController do

  context 'routing' do
    it {should route(:post, '/messages').to :action => :create}
  end

  context 'POST create' do
    context 'with valid parameters' do
      let(:valid_attributes) {{:name => 'michael', :message => 'my name is michael', :room_id => 1}}
      let(:valid_parameters) {{:message => valid_attributes}}

      it 'creates a new message' do
        expect {post :create, valid_parameters}.to change(Message, :count).by(1)
      end

      before {post :create, valid_parameters}

      it {should respond_with 201}
      it {should respond_with_content_type :json}
      it 'responds with a json representation of the newly-created message' do
        response.body.should eq Message.find(JSON.parse(response.body)['message']['id']).to_json
      end      
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) {{:name => ''}}
      let(:invalid_parameters) {{:message => invalid_attributes}}

      before {post :create, invalid_parameters}

      it {should respond_with 422}
      it {should respond_with_content_type :json}
      it 'responds with a json representation of the errors' do
        response.body.should eq Message.create(invalid_attributes).errors.to_json
      end
    end
  end

  # context 'GET index' do
  #   context 'limit to 20 messages' do
  #     let(:parameters) {{:limit => 20}}
  #     before {21.times {|num| Message.create({:name => "name#{num}", :message => "msg#{num}"})}}
  #     before {get :index, parameters}


  #     it {should respond_with 200}
  #     it {should respond_with_content_type :json}
  #     it 'responds with a json representation of the last 20 messages' do
  #       response.body.should eq Message.limit(20).to_json
  #     end
  #   end
  # end

end