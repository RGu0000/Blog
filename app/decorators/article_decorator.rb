class ArticleDecorator < Draper::Decorator
  delegate_all
  decorates_association :author

  def formatted_created_at
    created_at.strftime('%d.%m.%Y at %k:%M')
  end
end
