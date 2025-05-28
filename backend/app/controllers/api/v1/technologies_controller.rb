class Api::V1::TechnologiesController < ApplicationController
  before_action :set_technology, only: [:show]

  # GET /api/v1/technologies
  def index
    @technologies = Technology.order(:name)
    render json: @technologies
  end

  # GET /api/v1/technologies/:id
  def show
    render json: @technology
  end

  private

  def set_technology
    @technology = Technology.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Technology not found' }, status: :not_found
  end
end
