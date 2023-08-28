class DataController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update]

  def create
    data = Data.new(data_params)

    if data.save
      notify_third_party_apis(data)
      render json: { message: 'Data created successfully' }, status: :created
    else
      render json: { errors: data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    data = Data.find_by(id: params[:id])

    if data.nil?
      render json: { error: 'Data not found' }, status: :not_found
    else
      if data.update(data_params)
        notify_third_party_apis(data)
        render json: { message: 'Data updated successfully' }, status: :ok
      else
        render json: { errors: data.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def data_params
    params.require(:data).permit(:name, :data)
  end

  def notify_third_party_apis(data)
    third_party_endpoints = ['https://api.example.com/endpoint1', 'https://api.example.com/endpoint2']
    third_party_endpoints.each do |endpoint|
      response = HTTParty.post(endpoint, body: { data: data_params }, headers: { 'X-Auth-Secret': 'your_secret_key' })
      Rails.logger.info("Webhook response for #{endpoint}: #{response.code}")
    end
  end
end
