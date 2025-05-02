class Users::ApplicationController < ApplicationController
  layout 'users/application'
  before_action :authenticate_user!
end
