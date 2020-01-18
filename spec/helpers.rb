# typed: true
module Helpers
  sig { returns(T.untyped) }
  def event
    { 'repository': { 'owner': { 'login': "event_login" }, 'name': "event_name" } }
  end
end
