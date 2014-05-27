module ApplicationHelper

  def controller_action
    controller_path.gsub('/','-') + "-" + action_name
  end
  
end # module

