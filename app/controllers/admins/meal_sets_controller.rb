class Admins::MealSetsController < Admins::ApplicationController
  before_action :set_meal_set, only: %i[show edit update destroy]

  def index
    @meal_sets = MealSet.all.order(:id)
  end

  def show
  end

  def new
    @meal_set = MealSet.new
  end

  def create
    @meal_set = MealSet.new(meal_set_params)
    if @meal_set.save
      redirect_to admins_meal_set_path, notice: '食材セットを登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @meal_set.update(meal_set_params)
      redirect_to admins_meal_set_path, notice: '食材セットを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal_set.destroy
    redirect_to admins_meal_sets_path, notice: '食材セットを削除しました'
  end

  private

  def set_meal_set
    @meal_set = MealSet.find(params[:id])
  end

  def meal_set_params
    params.expect(meal_set: [:name, :price, :included_items, :weight, :refrigerated, :allergy_info, :recipe_pdf])
  end
end
