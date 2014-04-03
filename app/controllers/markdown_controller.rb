class MarkdownController < ActionController::Base

  include MarkdownHelper

  def preview
    @string = params[:string]
  end

end
