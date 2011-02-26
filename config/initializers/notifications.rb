#ActiveSupport::Notifications.subscribe "process_action.action_controller" do |name, start, finish, id, payload|
#  p "#{['notification: ', name, start, finish, id, payload].join(' ')}"
#end
