class CallbacksController < ApplicationController
  def messenger_verify
    render plain: params[:'hub.challenge']
  end

  def messenger
    render :json => { success: true }
  end
end
