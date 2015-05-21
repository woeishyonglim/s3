S3::Application.routes.draw do

  root :to => redirect("/file_types/user_id/uuid")
  match "upload" => "get_file#upload", via: :post
  match "download/*options" => "get_file#download"
  match "raw/*options" => "get_file#raw", format: false
  match "download/*options" => "get_file#raw", format: false
  match "remove" => "get_file#remove"
  match "/*options" => "get_file#file", format: false

end
