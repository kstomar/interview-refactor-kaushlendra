module Api
  module V1
    class EpisodeSerializer < ActiveModel::Serializer
      attributes :id,  :title
    end
  end
end
