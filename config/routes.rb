S3::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  root :to => redirect("/file_types/user_id/uuid")
  match "upload" => "get_file#upload", via: :post
  match "download*options" => "get_file#download"

#  match "file/*options" => "get_file#file", format: false
  match "/*options" => "get_file#file", format: false
#  match "try" => "get_file#try", format: false

end
