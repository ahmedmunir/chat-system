Rails.application.routes.draw do
  resources :applications, only: [:create, :show, :update], param: :token do
    resources :chats, only: [:index, :create], param: :number do
      resources :messages, only: [:index, :create] do
        collection do
          get 'search'
        end
      end
    end
  end
end
