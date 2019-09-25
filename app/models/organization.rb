class Organization < ApplicationRecord
  enum kind: { individual: 0, legal: 1 }
end
