module ApplicationHelper
  def bootstrap_alert_class(type)
    case type.to_sym
      when :notice then 'success'
      when :alert then 'danger'
      when :error then 'danger'
      else type.to_s
    end
  end

  def current_page_with_params(new_params)
    url_for(request.query_parameters.merge(new_params))
  end

end
