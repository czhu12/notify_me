class ListenersController < ApplicationController
  include ListenersHelper

  def email_preview
    @alert = Alert.last
    render :template => "alert_mailer/send_alert", :layout => false
  end

  def matches_query
    content = params[:content]
    query = params[:query]
    render :json => { match: Listener.matches_query?(content, query) }
  end

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
      charge(stripe_params[:email], stripe_params[:id])
      CreateListenerWorker.perform_async({
        listener_id: listener.id,
      })
      render :json => { success: true, listener: listener }
    else
      puts listener.errors.to_a
      social_watchers.each { |w| puts w.errors.to_a }
      render :json => { success: false }, status: 400
    end
  end

  def index
  end

  def show
    @listener = Listener.find_by_token!(params[:id])
  end

  def stripe_params
    params.require(:stripe_token).permit(:id, :email, :client_ip)
  end

  def listener_params
    params.require(:listener).permit(:phone_number, :email, :query, :social_watchers)
  end

  def charge(email, token)
    amount = 500 # 5 Dollars

    customer = Stripe::Customer.create(
      :email => email,
      :source  => token
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    return true
  rescue Stripe::CardError => e
    return false
  end
end
