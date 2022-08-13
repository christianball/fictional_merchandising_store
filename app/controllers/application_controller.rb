# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do |e|
    render(
      json: { error: e.message.to_s },
      status: 404
    )
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render(
      json: { errors: e.record.errors },
      status: 422
    )
  end
end
