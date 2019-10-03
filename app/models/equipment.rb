class Equipment < ApplicationRecord
  belongs_to :organization, optional: true

  enum kind: { laptop: 0, desktop: 1 }
end
