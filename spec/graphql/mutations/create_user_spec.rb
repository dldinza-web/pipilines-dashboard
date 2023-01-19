require 'rails_helper'

module Mutations
  describe CreateUser, type: :request do
    it 'create and user' do
      new_username = Faker::Internet.username

      request_body = <<~GQL
        mutation {
          createUser(input: { username: "#{new_username}" }) {
            user {
              id
              username
            }
          }
        }
      GQL

      post '/graphql', params: { query: request_body }
      json = JSON.parse response.body

      data = json['data']['createUser']['user']

      user = User.find(data['id'])

      expect(user.username).to eql new_username
      expect(data['username']).to eql new_username
    end
  end
end
