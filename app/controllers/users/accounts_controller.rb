class Users::AccountsController < Users::ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(account_params)
      redirect_to users_root_path, notice: 'アカウント情報を更新しました'
    else
      render :edit
    end
  end

  private

  def account_params
    params.require(:user).permit(
      :address,
      :prefecture,
      :shipping_zone,
      :phone_number,
      :allergy_notes
    )
  end
end
