class GetFileController < ApplicationController

  def raw
    file = FileFinder.find(params[:options])
    if file
      send_data(file.get.body.read, disposition: "inline", filename: file.key.split("/").last, type: file.get.content_type)
    else
      render :text => "No file found"
    end
  end

  def remove
    FileFinder.remove(params[:options])
    if params[:t] == "img"
      redirect_to "/#{params[:options]}?t=img"
    else
      redirect_to "/#{params[:options]}"
    end
  end

  def download
    file = FileFinder.find(params[:options])
    if file
      filename = file.key.split("/").last
      send_data(file.get.body.read, disposition: "download", filename: filename, type: file.get.content_type )
    else
      render :text => "No file found"
    end
  end

  def file
    redirect_to root_path and return unless params[:options].split("/").length == 3
    @title = "File viewer"
    @option = params[:options]
    @file = FileFinder.find(params[:options])
  end

  def instruction
   @title = "Configuration instruction"
  end

  def upload
    type = params[:t]
    if params[:attachment].blank?
      flash[:error] = "You have to drag or choose a file first."
      redirect_to "/#{params[:options]}" and return
    end

    if type == "img"
      message = FileUploader.image_upload(params[:options], params[:attachment])
      if message != "OK" && request.xhr?
        render :json => {:message => message}, :status => :unprocessable_entity and return
      end
      flash[:error] = message unless message == "OK"
      redirect_to "/#{params[:options]}?t=img"
    else
      resp = FileUploader.upload(params[:options], params[:attachment])
      flash[:error] = "You have to drag or choose a file first2." unless resp
      redirect_to "/#{params[:options]}"
    end
  end

end
