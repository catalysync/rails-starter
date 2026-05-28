require "sidekiq/web"

Rails.application.routes.draw do
  # ── Marketing (public) ──
  root "pages#landing"
  get "pricing",   to: "pages#pricing",   as: :pricing
  get "contact",   to: "pages#contact",   as: :contact
  get "changelog", to: "pages#changelog", as: :changelog
  get "landing",   to: "pages#landing",   as: :landing

  resources :blog, only: [ :index, :show ], controller: "blog"

  get "privacy", to: "legal#privacy", as: :privacy
  get "terms",   to: "legal#terms",   as: :terms

  # ── Authentication ──
  devise_for :users

  # ── Dashboard (authenticated) ──
  get "dashboard",           to: "dashboard#show",      as: :dashboard
  get "dashboard/analytics", to: "dashboard#analytics",  as: :dashboard_analytics
  get "dashboard/members",   to: "dashboard#members",    as: :dashboard_members
  get "dashboard/billing",   to: "dashboard#billing",    as: :dashboard_billing

  # ── Settings ──
  scope "dashboard/settings", as: :dashboard_settings do
    get "general",       to: "settings#general",       as: :general
    get "profile",       to: "settings#profile",        as: :profile
    get "notifications", to: "settings#notifications",  as: :notifications
  end

  # ── Accounts & Memberships ──
  resources :accounts, only: [ :index, :new, :create, :show, :edit, :update, :destroy ] do
    member do
      patch :switch
    end
    resources :memberships, only: [ :index, :update, :destroy ]
  end

  # ── Admin ──
  namespace :admin do
    get "/", to: "dashboard#show", as: :dashboard
    resources :users,     only: [ :index, :show ]
    resources :accounts,  only: [ :index, :show ]
    resources :customers, only: [ :index, :show ]
  end

  # ── API ──
  mount API => '/' if defined?(API)
  mount Scalar::UI, at: '/docs' if defined?(Scalar::UI)

  if Rails.env.local?
    authenticate :user, ->(u) { u.platform_admin? } do
      mount Sidekiq::Web => "/sidekiq"
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
