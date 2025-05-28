class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:show]

  # GET /api/v1/projects
  def index
    @projects = Project.includes(:technologies).order(end_date: :desc)
    render json: @projects, include: :technologies, methods: :image_url
  end

  # GET /api/v1/projects/:id
  def show
    render json: @project, include: :technologies, methods: :image_url
  end

  # POST /api/v1/projects
  def create
    # project_params_on_create から technology_ids を分離
    permitted_params = project_params_on_create
    technology_ids = permitted_params.delete(:technology_ids)

    @project = Project.new(permitted_params)

    if technology_ids.present?
      technologies = Technology.where(id: technology_ids)
      @project.technologies = technologies
    end

    if @project.save
      render json: @project, status: :created, location: api_v1_project_url(@project), include: :technologies, methods: :image_url
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.includes(:technologies).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Project not found' }, status: :not_found
  end

  def project_params_on_create
    params.require(:project)
          .permit(
            :title,
            :description,
            :role,
            :start_date,
            :end_date,
            :project_url,
            :github_url,
            :image,
            technology_ids: [] # 配列として受け取る
          )
  end
end
