module FileFinder

  def find(path)
   resource = Aws::S3::Resource.new(
     region: 'ap-southeast-1',
     credentials: Aws::Credentials.new(ENV['aws_key'],ENV['aws_secret_key'])
   )
   ob = resource.bucket(ENV['bucket_name']).objects(prefix: path).first
  end

  def remove(path)
    ob = find(path)
    if ob
      ob.delete
    end
  end

  module_function :find, :remove
end
