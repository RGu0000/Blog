module ArticleHelper
  def tag_list=(tags_string)
    tag_names = tags_string.scan(/\w+/).collect(&:downcase).uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

  def tag_list
    tags.collect(&:name).join(', ')
  end
end
