module Api
  module V1
    class EpisodesController < Api::V1::ApiController
      before_action :authenticate_user!
      before_action :set_tv_show
      before_action :set_episode, except: [:index, :create]

      def index
        render_success_response({
          episodes: array_serializer.new(@tv_show.episodes, serializer: Api::V1::EpisodeSerializer)
        }, status = 200)
      end

      def show
        render_success_response({
          episode: single_serializer.new(@episode, serializer: Api::V1::EpisodeSerializer)
        })
      end

      def create
        @episode = @tv_show.episodes.build(episode_params)
        if @episode.save
          render_success_response({
            episode: single_serializer.new(@episode, serializer: Api::V1::EpisodeSerializer)
          })
        else
          render_unprocessable_entity_response(@episode)
        end
      end

      def update
        if @episode.update(episode_params)
          render_success_response({
            episode: single_serializer.new(@episode, serializer: Api::V1::EpisodeSerializer)
          })
        else
          render_unprocessable_entity_response(@episode)
        end
      end

      def destroy
        if @episode.destroy
          render_success_response({}, "Destroyed Successfully")
        else
          render_unprocessable_entity_response(@episode)
        end

      end

      private

      def episode_params
        params.require(:episode).permit(:title, :watched)
      end

      def set_tv_show
        @tv_show = TvShow.find(params[:tv_show_id])
      end

      def set_episode
        @episode = @tv_show.episodes.find(params[:id])
      end
    end
  end
end
