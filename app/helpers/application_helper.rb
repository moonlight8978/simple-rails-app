module ApplicationHelper
  include Pagy::Frontend

  def classnames(*classes, **conditional_classes)
    [*classes, conditional_classes.select { |_class, condition| condition }.keys]
  end

  def form_control_classname(form, field)
    classnames("form-control", "is-invalid" => form.errors.where(field).any?)
  end
end
