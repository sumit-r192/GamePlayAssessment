# frozen_string_literal: true

class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  @@recent_uploaded_images = nil

  def create
    GamePlay.create(game_play_params)
  rescue StandardError => e
    redirect to root_path, errors: [e]
  end

  def index
    @game = GameImageBucket.new
  end

  def show
    @data = {}
    @picked_count = 0
    [10, 9, 8, 7, 6, 5, 4, 3, 2, 1].each { |i| image_data(i) }
    @game_plays = GamePlay.all.order('created_at DESC')
  end

  def upload
    redirect_to_home_page if params[:game_image_bucket][:images].blank?
    update_images
  end

  private

  def game_params
    params.require(:game_image_bucket).permit(images: [])
  end

  def game_play_params
    params.permit(:tick, :image_url)
  end

  def image_data(tick)
    @picked_count = 0 if pick_images[@picked_count].nil?
    @data[tick] = request.base_url.to_s + image_blob
    @picked_count += 1
  end

  def image_blob
    rails_blob_path(pick_images[@picked_count], only_path: true)
  end

  def pick_images
    @pick_images ||= @@recent_uploaded_images.sample([6, 7, 8, 9, 10].sample)
  end

  def redirect_to_home_page
    redirect_to root_path, flash: { error: 'You must select atleast 1 image' }
  end

  def upload_images
    @game = GameImageBucket.create(game_params)
    @@recent_uploaded_images = @game.images

    if @game.errors.present?
      redirect_to root_path, flash: { error: @game.errors.full_messages.first }
    else
      redirect_to games_path
    end
  end
end
