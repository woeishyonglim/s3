class GetFileController < ApplicationController
  def file
    if params[:options].split("/").length != 3
      redirect_to root_path and return
    end
    @title = "File viewer"
    @file = FileFinder.find(params[:options])
    if @file
      filename = @file.key.split("/").last
      send_data(@file.get.body.read, disposition: "inline", filename: filename, type: @file.get.content_type )
    end
  end

  def upload
    type = params[:t]
    if params[:attachment].blank?
      flash[:error] = "You have to drag or choose a file first."
      redirect_to "/#{params[:options]}"
    else
      if type == "img"
        FileUploader.image_upload(params[:options], params[:attachment])
        redirect_to "/#{params[:options]}?t=img"
      else
        FileUploader.upload(params[:options], params[:attachment])
        redirect_to "/#{params[:options]}"
      end
    end
  end
end
