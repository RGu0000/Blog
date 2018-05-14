class CommentDecorator < Draper::Decorator
  delegate_all

  def formatted_created_at
    created_at.strftime('%d.%m.%Y at %k:%M')
  end
end
