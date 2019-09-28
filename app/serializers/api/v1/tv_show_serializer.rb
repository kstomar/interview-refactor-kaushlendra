module Api
  module V1
    class TvShowSerializer < ActiveModel::Serializer
      attributes :id, :title, :episodes

      def episodes
        ActiveModel::Serializer::CollectionSerializer.new(object.episodes, serializer: EpisodeSerializer)
      end
    end
  end
end
