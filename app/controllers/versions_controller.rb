class VersionsController < ApplicationController
  before_action :set_document_and_version, only: [:show, :destroy]
  before_filter :authenticate_user!
  respond_to :json, :html, except: [:show]
  respond_to :xml, only: [:show]

  layout false

  def index
    @document = Document.find(params[:document_id])
    if @document.user_id == current_user.id
      @versions = @document.versions.order("created_at desc")
      respond_with @versions
    else
      respond_with status: 404
    end
  end

  def show
    if @version
      send_data @version.xml_content, filename: "#{@version.name}.xml", type: "application/xml", disposition: "attachment"
    else
      respond_with status: 404
    end
  end

  def destroy
    if @version
      @version.destroy
      respond_to do |format|
        format.html { redirect_to documents_url }
        format.json { head :no_content }
      end
    else
      respond_with status: 404
    end
  end

  private
    def set_document_and_version
      @version = DocumentVersion.where(id: params[:id], document_id: params[:document_id], user_id: current_user.id).first
    end
end
