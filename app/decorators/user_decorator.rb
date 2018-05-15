class UserDecorator < Draper::Decorator
  delegate_all

  def displayed_name
    return object.email if object.name.nil?
    object.name
  end
end
