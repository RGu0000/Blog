class RatingValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    rate = @record.rate
    valid_rates = (0..10).step(0.5).to_a
    raise_not_allowed_rate_error(:rate, @record) unless valid_rates.include? rate
  end

  private

  def raise_not_allowed_rate_error(field, record)
    record.errors[field] << 'rate must be between 0 and 10 (with 0.5 step)'
  end
end
