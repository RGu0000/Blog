class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def authorized?
    resource.author_id == user.id || user.admin?
  end
end
