class ContactsController < ApplicationController
  include ContactsHelper

  def index
    @user = User.find(params[:user_id])

    render json: @user.shared_contacts + @user.contacts
  end

  def show
    @contact = Contact.find(params[:id])
    if @contact
      render json: @contact
    else
      render json: "404 error", status: 404
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to :user_contacts
    else
      render json: @contact.errors.full_messages,status: :unprocessable_entity
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: @contact
  end
end
