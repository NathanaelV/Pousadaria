class Api::V1::InnsController < ActionController::API
  def show
    cnpj = params[:id]
    inn = Inn.find_by(registration_number: cnpj)
    room_types = inn.inn_rooms
    render status: 200, json: inn.as_json(include: :address)
  end
end
