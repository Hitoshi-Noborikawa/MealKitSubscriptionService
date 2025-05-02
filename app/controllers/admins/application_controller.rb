class Admins::ApplicationController < ApplicationController
  layout 'admins/application'
  before_action :authenticate_admin!
end
