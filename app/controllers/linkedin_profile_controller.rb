class LinkedinProfileController < ApplicationController

  def show
    render json: linkedin_service.profile(profile_options)
  end

  private


  def profile_options
    { fields: ['id', 'first-name', 'last-name', 'headline',
               'location', 'industry', 'num-connections',
               'summary', 'picture-url', 'positions'] }
  end

  def linkedin_service
    @linkedin_service ||= LinkedIn::API.new(Rails.configuration.linkedin_access_token)
  end
end