class CallbacksController < ApplicationController
  def messenger
    render plain: params[:'hub.challenge']
  end
end
