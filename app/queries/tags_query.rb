class TagsQuery
  def self.sort_by_occurances
    Tagging.all
           .joins(:tag)
           .select('tags.name, COUNT(taggings.id) AS tags_count')
           .group('tags.id')
           .order('tags_count desc')
  end
end
