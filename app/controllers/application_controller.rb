class ApplicationController < ActionController::Base

  def render_error(message='')
    render text: message,  status: 500
  end

  def render_not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def render_nothing
    render nothing: true
  end

end
