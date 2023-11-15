# require 'rails_helper'

# RSpec.describe EventsController, type: :controller do
#   let(:valid_attributes) { { name: 'My Event', date: '2023-12-31', hasCountdown: true } }

#   describe 'GET #new' do
#     it 'renders the new template' do
#         get :new
#         expect(response).to have_http_status(:ok)
#         expect(response).to render_template("new")
#     end
#   end

#   describe 'POST #create' do
#     context 'with valid parameters' do
#       it 'creates a new event' do
#         post :create, params: { event: valid_attributes }
#         expect(Event.last.name).to eq('My Event')
#         expect(response).to redirect_to(events_path)
#       end
#     end

#     context 'with invalid parameters' do
#       it 'renders the new template' do
#         post :create, params: { event: { name: '' } } # Invalid data
#         expect(response).to render_template('new')
#       end
#     end
#   end
# end
