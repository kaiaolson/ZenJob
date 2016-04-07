require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:consultant_user)   { FactoryGirl.create(:user, {role: "consultant"})  }
  let(:client_user)  { FactoryGirl.create(:user, {role: "client"}) }


  describe "#new" do
    it "renders the new user page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      context "user is a consultant" do
        def valid_request
          post :create, user: FactoryGirl.attributes_for(:user, {role: "consultant"})
        end
        it "creates a new user in the database" do
          expect{valid_request}.to change{User.count}.by(1)
        end
        it "logs the user in" do
          expect(session[:user_id]).to eq(User.last)
        end
        it "redirects to the requests index page" do
          expect(valid_request).to redirect_to(info_requests_path)
        end
        it "sets a flash notice message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "user is a client" do
        def valid_request
          post :create, user: FactoryGirl.attributes_for(:user, {role: "client"})
        end
        it "creates a new user in the database" do
          expect{valid_request}.to change{User.count}.by(1)
        end
        it "logs the user in" do
          valid_request
          expect(session[:user_id]).to eq(User.last.id)
        end
        it "redirects to the submissions index page" do
          expect(valid_request).to redirect_to(info_requests_path)
        end
        it "sets a flash notice message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end
    end

    context "with invalid attributes" do
      def invalid_request
        post :create, user: FactoryGirl.attributes_for(:user, {email: nil})
      end
      it "does not create a new user in the database" do
        expect{invalid_request}.to change{User.count}.by(0)
      end
      it "does not log the user in" do
        invalid_request
        expect(session[:user_id]).to eq(nil)
      end
      it "redirects to the new user page" do
        expect(invalid_request).to redirect_to(new_user_path)
      end
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#show" do
    context "with logged in user" do
      before do
        login(consultant_user)
        get :show, id: consultant_user.id
      end

      it "renders the user show page" do
        expect(response).to render_template(:show)
      end
    end

    context "without logged in user" do
      it "redirects to the login page" do
        get :show, id: consultant_user.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "#edit" do
    context "with logged in user" do
      before do
        login(consultant_user)
        get :edit, id: consultant_user.id
      end
      it "renders the edit user page" do
        expect(response).to render_template(:edit)
      end
    end

    context "without logged in user" do
      it "redirects to the login page" do
        get :edit, id: consultant_user.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "#update" do
    context "with logged in user" do
      before { login(consultant_user) }

      context "with valid attributes" do
        def valid_request
          patch :update, id: consultant_user.id, user: FactoryGirl.attributes_for(:user, {first_name: "Kaia"})
        end
        it "updates the user in the database" do
          valid_request
          expect(consultant_user.reload.first_name).to eq("Kaia")
        end
        it "redirects to the user show page" do
          expect(valid_request).to redirect_to(user_path(consultant_user))
        end
        it "sets a flash notice message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with invalid attributes" do
        def invalid_request
          patch :update, id: consultant_user.id, user: FactoryGirl.attributes_for(:user, {email: nil})
        end
        it "does not update the user in the database" do
          invalid_request
          expect(consultant_user.email).to_not eq(nil)
        end
        it "redirects to the user edit page" do
          expect(invalid_request).to render_template(:edit)
        end
        it "sets a flash alert message" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end
    end

    context "without logged in user" do
      it "redirects to the login page" do
        patch :update, id: consultant_user.id, user: FactoryGirl.attributes_for(:user, {first_name: "Kaia"})
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "#destroy" do
    context "with logged in user" do
      before { login(consultant_user) }

      context "when logged in user is the same as the user to be destroyed" do
        def destroy_user
          consultant_user
          delete :destroy, id: consultant_user.id
        end
        it "destroys the user in the database" do
          expect{destroy_user}.to change{User.count}.by(-1)
        end
        it "destroys the session" do
          destroy_user
          expect(session[:user_id]).to eq(nil)
        end
        it "redirects to the home page" do
          expect(destroy_user).to redirect_to(root_path)
        end
        it "sets a flash notice message" do
          destroy_user
          expect(flash[:notice]).to be
        end
      end

      context "when logged in user is not the same as the user to be destroyed" do
        before { client_user }
        def destroy_other_user
          delete :destroy, id: client_user.id
        end
        it "does not destroy the user in the database" do
          expect{destroy_other_user}.to change{User.count}.by(0)
        end
        it "redirects to the home page" do
          expect(destroy_other_user).to redirect_to(root_path)
        end
      end
    end

    context "without logged in user" do
      it "redirects to the login page" do
        consultant_user
        delete :destroy, id: consultant_user.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
