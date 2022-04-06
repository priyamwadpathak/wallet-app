Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'api/v1/init', to: 'api/v1/users#init'
  get 'api/v1/wallet', to: 'api/v1/wallets#get_wallet'
  post 'api/v1/wallet', to: 'api/v1/wallets#init'
  patch 'api/v1/wallet', to: 'api/v1/wallets#init'
  post 'api/v1/wallet/deposits', to: 'api/v1/transactions#deposit'
  post 'api/v1/wallet/withdrawals', to: 'api/v1/transactions#withdrawals'
end
