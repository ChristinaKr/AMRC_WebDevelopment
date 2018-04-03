Rails.application.routes.draw do



  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: {
               sessions: 'users/sessions',
               passwords: 'users/passwords',
               registrations: 'users/registrations'
             }
  get 'users/form_submit'

  resources :users, :except => [:show] do
    member do
      get :delete
    end
  end

  get 'users/indextem'

  get 'amrc_edit/tem_options'

  get "charity_lp/lp_tem"

  get 'amrc_reports/reports'
  get 'amrc_reports/dash_data'

  get 'amrc_reports/research_individual'
  get 'amrc_reports/grants_individual'

  match 'amrc_reports/get_rex' => 'amrc_reports#get_rex', :as => :get_rex, :via => :get
  match 'amrc_reports/get_unsubmitted' => 'amrc_reports#get_unsubmitted', :as => :get_unsubmitted, :via => :get
  match 'amrc_reports/get_grant_data' => 'amrc_reports#get_grant_data', :as => :get_grant_data, :via => :get
  match 'amrc_reports/to_csv_dash_data' => 'amrc_reports#to_csv_dash_data', :as => :to_csv_dash_data, :via => :get
  match 'amrc_reports/:charity/reports' => 'amrc_reports#reports_individual', :as => :reports_individual, :via => :get
  match 'amrc_reports/get_individual/:charity_id' => 'amrc_reports#get_individual', :as => :get_individual, :via => :get
  match 'amrc_reports/get_individual_grant/:charity_id' => 'amrc_reports#get_individual_grant', :as => :get_individual_grant, :via => :get
  match 'amrc_edit/delete_all_records' => 'amrc_edit#delete_all_records', :as => :delete_all_records, :via => :get


get 'rails_admin/admin'


  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user


  get 'amrc_dashboard/templatedash'


  get 'grant_upload/grant_data'
  get 'grant_upload/grant_data/show'

  get 'amrc_dashboard/dashboard'
  get 'devise/amrc_dashboard/dashboard'
  get 'users/amrc_dashboard/dashboard'

  get 'amrc_edit/add_new_charity'
  get 'amrc_edit/edit_charity'
  get 'amrc_edit/edit_options'
  get 'devise/amrc_edit/edit_options'
  get 'users/amrc_edit/edit_options'

  get 'amrc_reports/reports'
  get 'devise/amrc_reports/reports'
  get 'users/amrc_reports/reports'

  get 'charity_lp/landingpage'

  get 'projects/index'
  get 'projects/show'
  get 'projects/form'
  get 'projects/approval'
  get 'projects/contact_details'
  get 'projects/estimated_spending'
  get 'projects/other_charity_spending'
  get 'projects/spending_on_research'
  get 'projects/total_charitable_activities'
  get 'projects/use_of_data'
  get 'projects/edit'

  # resources :projects, :except => [:show]

  root :to => 'passthrough#index'

  get 'amrc_edit/delete_all'

  get 'landing_page/landingPage'

  resources :grant_upload do
    collection {post :import}
  end

  resources :projects

  resources :amrc_reports, :except => [:show]

end
