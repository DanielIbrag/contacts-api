class ContactsController < ApplicationController
  def index
    contacts = Contact.all
    render json: contacts.as_json
  end

  def create
    contact = Contact.new(
      first_name: params["first_name"],
      last_name: params["last_name"],
      email: params["email"],
      phone_number: params["phone_number"],
      user_id: current_user.id,
    )
    if contact.save
      render json: contact
    else
      render json: { error_messages: contact.errors.full_messages },
             status: 422
    end
  end

  def show
    single_route = Contact.find_by(id: params["id"])
    render json: single_route
  end

  def patch
    contact_id = params["id"]
    contact = Contact.find(contact_id)
    contact.first_name = params["first_name"] || contact.first_name
    contact.last_name = params["last_name"] || contact.last_name
    contact.email = params["email"] || contact.email
    contact.phone_number = params["phone_number"] || contact.phone_number
    if contact.save
      render json: contact
    else
      render json: { error_messages: contact.errors.full_messages },
             status: 422
    end
  end

  def destroy
    id = params[:id]
    contact = Contact.find_by(id: id)
    contact.destroy
    render json: { message: "Product successfully destroyed!" }
  end
end
