# typed: ignore

module Helpers
  extend T::Sig

  sig { returns(T::Hash[Symbol, T::Hash[Symbol, T.any(String, T::Hash[Symbol, String])]]) }
  def event
    { 'repository': { 'owner': { 'login': "event_login" }, 'name': "event_name" } }
  end
end
