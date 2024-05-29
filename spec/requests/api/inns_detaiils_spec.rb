require 'rails_helper'

describe 'Inn API' do
  context 'GET /api/v1/inns' do
    it 'succesffuly' do
      inn_owner = InnOwner.create!(first_name: 'Leonardo', last_name: 'yoshi',  document: '40403364027',
                                  email: 'leonardo.yoshi@email.com', password: 'leonardo123')
      inn = inn_owner.create_inn!(name: 'Pousada TMNT', registration_number: '48788967000106',
                                  description: 'Um ótimo lugar', address_attributes: { 
                                    address: 'Rua New York', number: '400', city: 'São Paulo', state: 'SP',
                                    postal_code: '09067-080', neighborhood: 'Centro'
                                  })
      
      inn.inn_rooms.create!(name: 'Quarto com Varanda', size: 35, guest_limit: 3)
      inn.inn_rooms.create!(name: 'Quarto Térreo', size: 30, guest_limit: 3)

      get '/api/v1/inns/48788967000106'
      
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'Pousada TMNT'
      expect(json_response['registration_number']).to eq '48788967000106'
      expect(json_response['description']).to eq 'Um ótimo lugar'
      expect(json_response['address_attributes']['address']).to eq 'Rua New York'
      expect(json_response['address_attributes']['number']).to eq '400'
      expect(json_response['address_attributes']['city']).to eq 'São Paulo'
      expect(json_response['address_attributes']['state']).to eq 'SP'
      expect(json_response['address_attributes']['postal_code']).to eq '09067-080'
      expect(json_response['address_attributes']['neighborhood']).to eq 'Centro'
    end
  end
end
