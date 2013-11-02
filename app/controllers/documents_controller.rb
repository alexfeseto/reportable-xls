class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  respond_to :json, :html, except: [:show]
  respond_to :xml, only: [:show]

  def index
    page_num = params[:page] || 0
    @documents = Document.top_by_user(current_user.id).page(page_num).to_a
  end

  def show
    respond_with(status: 404) && return unless @document
    last_version = @document.latest_version
    send_data last_version.xml_content, filename: "#{last_version.name}.xml", type: "application/xml", disposition: "attachment"
  end

  def new
    @document = Document.new
    @document_version = DocumentVersion.new
  end

  def edit
    respond_with(status: 404) && return unless @document
    last_version = @document.latest_version
    @document_version = DocumentVersion.new(name: last_version.name)
  end

  def create
    @document = Document.new
    @document.user_id = current_user.id

    @document.versions.build(document_version_params)
    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_url, notice: 'Document was successfully created.' }
        format.json { render action: 'index', status: :created, location: documents_url }
      else
        @document_version = DocumentVersion.new
        format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_with(status: 404) && return unless @document
    respond_to do |format|
      @document_version = @document.versions.build(document_version_params)
      @document_version.errors.add(:base, 'You are not the owner of this document.') unless @document.user.id == current_user.id
      if @document_version.save
        format.html { redirect_to documents_url, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document_version.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_with(status: 404) && return unless @document
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.where(id: params[:id], user_id: current_user.id).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_version_params
      params.require(:document_version).permit(:name, :file)
    end
end
