class ContactsController < ApplicationController
  before_action :signed_in_user

  def new
    @contact = Contact.new
    @users = User.from_not_contacted(current_user)
    @contacted_ids = []
  end

  def create
    contacted_ids = params[:contacted_ids].collect {|contacted_ids| contacted_ids.to_i} if params[:contacted_ids]
    if contacted_ids
      contacted_ids.each do |contacted_id|
        current_user.make_contact!({:contacted_id => contacted_id})
      end
    end
    redirect_to '/'
  end
end
