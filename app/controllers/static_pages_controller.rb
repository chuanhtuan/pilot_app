class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
      @users = @user.contacted_users.all
      @receiver = nil#User.find(2)
      @histories = nil#@receiver.histories_with(@user).paginate(page: params[:page], :order => 'created_at DESC')
      @history  = History.new
    end

  end

  def help
  end
end
