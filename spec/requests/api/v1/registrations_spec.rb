RSpec.describe "POST '/api/v1/auth", type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'with valid credentials' do
    before do
      post '/api/v1/auth',
        params: {
          email: 'example@craftacademy.se',
          password: 'password',
          password_confirmation: 'password'
        },
        headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns a success message' do
      expect(response_json['status']).to eq 'success'
    end
  end

  context 'when a user submits' do
    describe 'a non-matching password confirmation' do
      before do
        post '/api/v1/auth',
          params: {
            email: 'example@ca.com',
            password: 'password',
            password_confirmation: 'wrong_password'
          },
          headers: headers
      end

      it 'returns a 422 response status' do
        expect(response).to have_http_status 422
      end
    
      it 'returns an error message' do
        expect(response_json['errors']['password_confirmation']).to eq ["doesn't match Password"]
      end
    end

    describe 'a non-valid email address' do
      before do
        post '/api/v1/auth',
          params: {
            email: 'example@ca',
            password: 'password',
            password_confirmation: 'password'
          },
          headers: headers
      end

      it 'expect a 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'returns an error message' do
        expect(response_json['errors']['email']).to eq ['is not an email']
      end
    end

    describe 'an already registered email' do
      let!(:registered_user) { create(:user, email: 'coach@ca.se')}

      before do
        post '/api/v1/auth',
          params: {
            email: 'coach@ca.se',
            password: 'password',
            password_confirmation: 'password'
          },
          headers: headers
      end

      it 'expect a 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'returns an error message' do
        expect(response_json['errors']['email']).to eq ['has already been taken']
      end 
    end

    context 'when a user does not submit' do
      describe 'any email' do
        before do
          post '/api/v1/auth',
            params: {
              email: '',
              password: 'password',
              password_confirmation: 'password'
            },
            headers: headers
        end
  
        it 'returns a 422 response status' do
          expect(response).to have_http_status 422
        end
      
        it 'returns an error message' do
          expect(response_json['errors']['email']).to eq ["can't be blank"]
        end
      end
    end
    
    context 'when a user does not submit' do
      describe 'any password' do
        before do
          post '/api/v1/auth',
            params: {
              email: 'ca@ca.se',
              password: '',
              password_confirmation: ''
            },
            headers: headers
        end
  
        it 'returns a 422 response status' do
          expect(response).to have_http_status 422
        end
      
        it 'returns an error message' do
          expect(response_json['errors']['password']).to eq ["can't be blank"]
        end
      end
    end
      
    context 'when a user does not submit' do
      describe 'any password confirmation' do
        before do
          post '/api/v1/auth',
            params: {
              email: 'ca@ca.se',
              password: 'password123',
              password_confirmation: ''
            },
            headers: headers
        end
  
        it 'returns a 422 response status' do
          expect(response).to have_http_status 422
        end
      
        it 'returns an error message' do
          expect(response_json['errors']['password_confirmation']).to eq ["doesn't match Password"]
        end
      end
    end
  end
end 