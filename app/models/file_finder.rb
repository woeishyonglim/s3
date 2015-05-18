module FileFinder

  def find(path)
   resource = Aws::S3::Resource.new(
     region: 'ap-southeast-1',
     credentials: Aws::Credentials.new(ENV['aws_key'],ENV['aws_secret_key'])
   )
   ob = resource.bucket("woeishyong").objects(prefix: path).first
  end

  module_function :find
end
