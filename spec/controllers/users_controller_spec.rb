# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'authenticate' do
    let(:valid_user) { create(:user, username: 'koks24', password: 'parole123') }

    context 'with valid credentials' do
      it 'redirects to welcome page' do
        post :authenticate, params: { username: valid_user.username, password: valid_user.password }
        expect(response).to redirect_to(welcome_page_url)
        expect(session[:user_id]).to eq(valid_user.id)
      end
    end

    context 'with invalid credentials' do
      it 'renders login page with error message' do
        post :authenticate, params: { username: 'invalid_username', password: 'invalid_password' }
        expect(response).to render_template(:login)
        expect(assigns(:user).errors.full_messages).to include('Nederīgs lietotājvārds vai parole!')
      end
    end

    context 'with missing credentials' do
      it 'renders login page with error message' do
        post :authenticate, params: { username: '', password: '' }
        expect(response).to render_template(:login)
        expect(assigns(:user).errors.full_messages).to include('Lauki nevar būt tukši!')
      end
    end
  end
end
