class DownloadsController < ApplicationController
  load_and_authorize_resource

  layout 'admin'

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @downloads }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @download }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @download }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @download.save
        format.html { redirect_to @download, notice: 'Download was successfully created.' }
        format.json { render json: @download, status: :created, location: @download }
      else
        format.html { render action: "new" }
        format.json { render json: @download.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @download.update_attributes(params[:download])
        format.html { redirect_to @download, notice: 'Download was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @download.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @download.destroy

    respond_to do |format|
      format.html { redirect_to downloads_url }
      format.json { head :no_content }
    end
  end
end
