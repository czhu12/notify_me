class ListenersController < ApplicationController
  def create
    listener = Listener.new(listener_params)
    social_watchers = []
    social_watchers = params[:listener][:social_watchers].map do |w|
      watcher = SocialWatcher.new(
        score: w[:score],
        source: w[:source],
        metadata: w[:metadata].permit!.to_h,
      )
      watcher.listener = listener
      watcher
    end if params[:listener][:social_watchers]

    all_valid = social_watchers.all? { |watcher| watcher.valid? }
    if all_valid and listener.save
      social_watchers.each { |w| w.save }
      render :json => { success: true, listener: listener }
    else
      puts listener.errors.to_a
      social_watchers.each { |w| puts w.errors.to_a }
      render :json => { success: false }, status: 400
    end
  end

  def index
    @listener = Listener.new
  end

  def show
    @listener = Listener.find_by_token(params[:id])
  end

  def listener_params
    params.require(:listener).permit(:phone_number, :email, :query, :social_watchers)
  end
end
