# frozen_string_literal: true

class ErrorsController < ApplicationController
  def not_found
    render status: :not_found
  end

  def internal_server_error
    render status: 500
  end
end
