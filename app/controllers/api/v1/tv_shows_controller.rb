module Api
  module V1
    class TvShowsController < Api::V1::ApiController
      before_action :authenticate_user!
      before_action :set_tv_show, except: [:index, :create]

      def index
        @tv_shows = current_user.tv_shows
        render_success_response({
          tv_shows: array_serializer.new(@tv_shows, serializer: Api::V1::TvShowSerializer)
        }, status = 200)
      end

      def show
        render_success_response({
          tv_show: single_serializer.new(@tv_show, serializer: Api::V1::TvShowSerializer)
        })
      end

      def create
        @tv_show = current_user.tv_shows.new(tv_show_params)
        if @tv_show.save
          render_success_response({
            tv_show: single_serializer.new(@tv_show, serializer: Api::V1::TvShowSerializer)
          })
        else
          render_unprocessable_entity_response(@tv_show)
        end
      end

      def update
        if @tv_show.update(tv_show_params)
          render_success_response({
            tv_show: single_serializer.new(@tv_show, serializer: Api::V1::TvShowSerializer)
          })
        else
          render_unprocessable_entity_response(@tv_show)
        end
      end

      def destroy
        if @tv_show.destroy
          render_success_response(@tv_show, "Destroyed Successfully")
        else
          render_unprocessable_entity_response(@tv_show)
        end
      end

      private

      def set_tv_show
        @tv_show = TvShow.find(params[:id])
      end

      def tv_show_params
        params.require(:tv_show).permit(:title)
      end
    end
  end
end
