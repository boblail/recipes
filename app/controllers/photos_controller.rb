class PhotosController < ApplicationController
  before_action :authenticate_user!

  def create
    @photo = Photo.create!(filename: params.require(:photo))
    render json: { id: @photo.id, url: @photo.url }, status: :created
  end

end
