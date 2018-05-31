require 'set'

module UserServices
  class UserAndAssociationsDestroyer
    def self.call(user_id)
      article_ids = User.find(user_id).article_ids

      Tagging.where(article_id: article_ids).delete_all
      Comment.where(article_id: article_ids).delete_all
      Article.where(id: article_ids).delete_all
      Rating.where(author_id: user_id).delete_all
      Bookmark.where(user_id: user_id).delete_all

      comments = Set.new
      Comment.includes(:descendant_hierarchies)
             .where(author_id: user_id)
             .each do |comment|
               comment.self_and_descendants.map(&:id)
             end
      Comment.where(id: comments).delete_all
    end
  end
end
