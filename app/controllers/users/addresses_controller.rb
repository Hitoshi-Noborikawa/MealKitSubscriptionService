class Users::AddressesController < Users::ApplicationController
  before_action :set_address, only: %i[edit update destroy]

  def index
    @addresses = current_user.addresses
  end

  def new
    @address = current_user.addresses.build
  end

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      redirect_to users_addresses_path, notice: '住所を追加しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @address.update(address_params)
      redirect_to users_addresses_path, notice: '住所を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
    redirect_to users_addresses_path, notice: '住所を削除しました'
  end

  private

  def set_address
    @address = current_user.addresses.find(params[:id])
  end

  def address_params
    # TODO: exceptにする
    params.require(:address).permit(
      :postal_code, :prefecture, :city, :street, :phone_number
    )
  end
end
