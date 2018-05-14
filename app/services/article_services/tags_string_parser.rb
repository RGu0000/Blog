module ArticleServices
  class TagsStringParser
    def initialize(tags_string)
      @tags_string = tags_string
    end

    def call
      @tags_string.scan(/\w+/)
                  .collect(&:downcase)
                  .uniq
                  .collect { |name| Tag.find_or_create_by(name: name) } if @tags_string.present?
    end
  end
end
