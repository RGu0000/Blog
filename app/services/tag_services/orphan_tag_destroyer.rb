module TagServices
  class OrphanTagDestroyer
    def self.call
      Tag.where.not(id: Tagging.pluck('DISTINCT tag_id'))
         .delete_all
      # Tagging.where('article_id = ?', article_id).delete_all
      # Comment.where('article_id = ?', article_id).delete_all
    end
  end
end
