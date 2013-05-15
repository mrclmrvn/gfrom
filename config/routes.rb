Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :google_forms do
    resources :google_forms, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :google_forms, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :google_forms, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
