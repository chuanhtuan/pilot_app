class HistoriesController < ApplicationController
  before_action :signed_in_user

  def show
    @receiver = User.find(params[:id])
    @histories = @receiver.histories_with(current_user).paginate(:page => params[:page], :order => 'created_at DESC')
    respond_to do |format|
      format.html { render :partial => "shared/histories", :histories => @histories, :receiver => @receiver }
      format.js {
        render 'histories/show'
      }
    end
  end

  def create
    @history = History.new(history_params)
    if @history.save!
      # respond_to do |format|
      #   format.html { render :partial => "histories/history", :history => @history }
      #   format.js {
      #     render 'histories/create'
      #   }
      # end
      #user_msg :new_message, message[:msg_body].dup
      logger.info "----------send to receiver----------"
      event = WebsocketRails::Event.new(:new_message, data: {
        user_name:  @history.poster.name, 
        received:   Time.now.to_s(:short), 
        msg_body:   ERB::Util.html_escape(@history.content) 
      })
      WebsocketRails.users[@history.receiver.id.to_s].trigger event

      # logger.info "----------broadcast message----------"
      # WebsocketRails.users.each do |connection|
      #   event = WebsocketRails::Event.new(:new_message, data: {
      #     user_name:  @history.poster.name, 
      #     received:   Time.now.to_s(:short), 
      #     msg_body:   ERB::Util.html_escape(@history.content) 
      #   })
      #   connection.trigger event
      # end
      #WebsocketRails["system"].trigger event
      #binding.pry
      # WebsocketRails.users[@history.receiver.id.to_s].send_message :new_message, { 
      # WebsocketRails.broadcast_message Event.new(:new_message, data: {
      #   user_name:  @history.poster.name, 
      #   received:   Time.now.to_s(:short), 
      #   msg_body:   ERB::Util.html_escape(@history.content) 
      # })
      # WebsocketRails.users.send_message :new_message, { 
      # user_name:  @history.poster.name, 
      # received:   Time.now.to_s(:short), 
      # msg_body:   ERB::Util.html_escape(@history.content) 
      # }
      #WebsocketRails[@history.receiver.email].trigger :new_message, @history.content
      logger.info "----------end----------"
    end
  end

  # def aaa(connection)
  #   event = WebsocketRails::Event.new(:new_message, data: {
  #       user_name:  @history.poster.name, 
  #       received:   Time.now.to_s(:short), 
  #       msg_body:   ERB::Util.html_escape(@history.content) 
  #     })
  #   connection.trigger event
  # end

  def history_params
    params.require(:history).permit(:poster_id, :receiver_id, :content)
  end

end