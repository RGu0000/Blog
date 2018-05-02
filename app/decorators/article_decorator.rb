class ArticleDecorator < Draper::Decorator
  delegate_all

  def all_tags
    return 'no tags specified' if tags_blank?
    tags_string
  end

  private

  def tags_blank?
    object.tags.blank?
  end

  def tags_string
    object.tags.each_with_object('|') { |tag, string| string << " ##{tag.name} |" }
  end
end
