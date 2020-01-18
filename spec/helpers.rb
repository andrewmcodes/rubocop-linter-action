# typed: true
module Helpers
  def event
    { 'repository': { 'owner': { 'login': "event_login" }, 'name': "event_name" } }
  end
end
