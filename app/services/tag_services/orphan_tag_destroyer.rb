module TagServices
  class OrphanTagDestroyer
    def self.call
      Tag.where.not(id: Tagging.pluck('DISTINCT tag_id'))
         .destroy_all
    end
  end
end
