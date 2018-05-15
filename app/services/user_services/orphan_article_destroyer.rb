module UserServices
  class OrphanArticleDestroyer
    def self.call(id)
      Article.where('author_id = ?', id).delete_all
      Comment.where('author_id = ?', id).delete_all
    end
  end
end
