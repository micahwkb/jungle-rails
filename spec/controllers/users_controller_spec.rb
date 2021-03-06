require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do
    context 'with invalid attributes' do
      it 'does not create new user' do
        count = User.count
        post :create, user: attributes_for(:user)
        expect(User.count).to eq(count + 1)
      end
    end
  end
end
