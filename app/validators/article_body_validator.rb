class ArticleBodyValidator < ActiveModel::Validator
  def validate(record)
    initialize_instance_variables(record)
    validate_title
  end

  private

  def initialize_instance_variables(record)
    @record = record
    @body = record.body
    @forbidden_words = %w[noob n00b looser feeder newbie lame]
  end

  def validate_title
    raise_prohibited_word(:body, @record) if @forbidden_words.any? { |word| @body.include?(word) }
  end

  def raise_prohibited_word(field, record)
    record.errors[field] << ' - forbidden word detected'
  end
end
