class UserDecorator < Draper::Decorator
  delegate_all

  def displayed_name
    return object.email if object.name.empty?
    object.name
  end
end
