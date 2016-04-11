require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:consultant_user)  { FactoryGirl.create(:user, {role: "consultant"})  }
  let(:client_user) { FactoryGirl.create(:user, {role: "client"}) }

  describe "#new" do
    it "renders the login page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do

    context "with valid credentials" do
      context "the user is a consultant" do
        before do
          post :create, {email: consultant_user.email,
                         password: consultant_user.password}
        end

        it "initializes a new session" do
          expect(session[:user_id]).to be
        end
        it "sets a flash notice message" do
          expect(flash[:notice]).to be
        end
        it "redirects to the requests index page" do
          expect(response).to redirect_to(info_requests_path)
        end
      end

      context "the user is a client" do
        before do
          post :create, {email: client_user.email,
                         password: client_user.password}
        end

        it "initializes a new session" do
          expect(session[:user_id]).to be
        end
        it "sets a flash notice message" do
          expect(flash[:notice]).to be
        end
        it "redirects to the requests index page" do
          expect(response).to redirect_to(info_requests_path)
        end
      end
    end

    context "with invalid credentials" do
      before do
        post :create, {email: "test@test.com",
                       password: "testing_password"}
      end

      it "redirects to the login page" do
        expect(response).to redirect_to(new_session_path)
      end
      it "sets a flash alert message" do
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
    before do
      login(consultant_user)
      delete :destroy, id: session[:user_id]
    end

    it "destroys the session" do
      expect(session[:user_id]).not_to be
    end
    it "redirects to the home page" do
      expect(response).to redirect_to(root_path)
    end
    it "sets a flash notice message" do
      expect(flash[:notice]).to be
    end
  end
end
