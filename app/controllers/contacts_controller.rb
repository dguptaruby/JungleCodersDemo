require 'vpim/vcard'
# contacts controller class
class ContactsController < ApplicationController
  include VCardHandler
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = current_user.contacts
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = current_user.contacts.new(contact_params)
    @contact.name = params["name"]
    @contact.email = params["email"]
    @contact.phone = params["phone"]
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.archived = true
    @contact.save
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully removed.' }
      format.json { head :no_content }
    end
  end

  # Generate and download vcf file of a contact
  def generate_vcard
    contacts = current_user.contacts.where(id: params[:contact_id]).last
    v_card_single(contacts) if contacts.present?
  end

  def generate_vcards
    contacts = current_user.contacts.all
    v_card_multiple(contacts) if contacts.present?
    redirect_to 'contacts#index'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    if has_contact?
      @contact = current_user.contacts.friendly.find(params[:id])
    else
      flash[:error] = 'No such contact found'
      redirect_to root_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit( :address, :organization, :birthday)
  end

  def has_contact?
    current_user.contacts.all.include? Contact.where(slug: params[:id]).first
  end
end
