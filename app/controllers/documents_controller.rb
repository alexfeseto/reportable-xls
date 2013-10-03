class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  respond_to :json, :html, except: [:show]
  respond_to :xml, only: [:show]

  def index
    page_num = params[:page] || 0
    @documents = Document.top_by_user(current_user.id).page(page_num).all
  end

  def show
    send_data @document.xml_content, filename: "#{@document.name}.xml", type: "application/xml", disposition: "attachment"
  end

  def new
    @document = Document.new
  end

  def edit
  end

  def create
    @document = Document.new(document_params)
    @document.user_id = current_user.id

    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_url, notice: 'Document was successfully created.' }
        format.json { render action: 'index', status: :created, location: documents_url }
      else
        format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @document.errors.add(:base, 'You are not the owner of this document.') unless @document.user.id == current_user.id
      if @document.update(document_params)
        format.html { redirect_to documents_url, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :file)
    end
end
