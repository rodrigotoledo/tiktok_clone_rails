# frozen_string_literal: true

class Api::ApplicationController < ActionController::API
  include Api::AuthenticationConcern
end
