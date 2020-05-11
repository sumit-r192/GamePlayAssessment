# frozen_string_literal: true

module GamesHelper
  def check_visibility_class
    'hide' if @game_plays.blank?
  end
end
