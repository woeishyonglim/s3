module FileUploader
  APPROVED_FILE_TYPE = %w(
    image/png
    image/jpeg
    image/gif
    image/tiff
  )

  def get_path(path, data)
    paths = path.split("/")
    folders = paths[0..-1].join("/")
    record_id = paths.last
    extension = File.extname(data.original_filename)
    proposed_filename = record_id + extension
    return proposed_path = "#{folders}/#{proposed_filename}"
  end


  def upload(path, data)
    s3 = Aws::S3::Client.new(
      region: 'ap-southeast-1',
      credentials: Aws::Credentials.new(ENV['aws_key'], ENV['aws_secret_key'])
     )
     content_type = data.content_type if data
    resp = s3.put_object(
      bucket: ENV['bucket_name'],
      key: get_path(path, data),
      body: data,
      content_type: content_type
    )
  end


  def image_upload(path, data, width=200)
    content_type = data.content_type if data
    return "Only accept image type like JPG, PNG, and GIF" unless APPROVED_FILE_TYPE.include?(content_type)
    return "OK" unless !upload(path,data)
  end

  module_function :upload, :image_upload, :get_path
end
