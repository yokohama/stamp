module ApplicationHelper

  def error_message(obj)
    if obj.errors.any?
      html = "<div class='alert alert-danger'><ul>"
      obj.errors.full_messages.each do |message|
        html = html + "<li>#{message}</li>"
      end
      html = html + "</ul></div>"
      html.html_safe
    end
  end
end
