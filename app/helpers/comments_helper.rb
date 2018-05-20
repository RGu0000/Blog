module CommentsHelper
  def comments_tree_for(comments)
    comments.map do |comment, nested_comments|
      render(comment) +
        (nested_comments.size.positive? ? content_tag(:div, comments_tree_for(nested_comments), class: 'replies') : nil)
    end.join.html_safe
  end
end
