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
        message = FileUploader.image_upload(params[:options], params[:attachment])
        if message == "OK"
          redirect_to "/#{params[:options]}?t=img"
        else
          flash[:error] = message
          redirect_to "/#{params[:options]}?t=img"
        end
      else
        if FileUploader.upload(params[:options], params[:attachment])
          redirect_to "/#{params[:options]}"
        else
          flash[:error] = "You have to drag or choose a file first."
          redirect_to "/file/#{params[:options]}"
        end
      end
    end
  end
end
