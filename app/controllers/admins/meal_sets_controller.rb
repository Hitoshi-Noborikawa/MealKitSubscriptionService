class Admins::MealSetsController < Admins::ApplicationController
  before_action :set_meal_set, only: %i[show edit update destroy]

  def index
    @meal_sets = MealSet.all.order(:id)
  end

  def show
  end

  def new
    @meal_set = MealSet.new
    # TODO: 初期値は一番上の食材を固定. modelに書きたい
    @meal_set.meal_set_items.build(meal: Meal.default_order.first)
  end

  def create
    @meal_set = MealSet.new(meal_set_params)
    if @meal_set.save
      redirect_to admins_meal_sets_path(@meal_set), notice: '食材セットを登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # TODO: 微妙
    if @meal_set.meal_set_items.empty?
      @meal_set.meal_set_items.build
    end
  end

  def update
    if @meal_set.update(meal_set_params)
      redirect_to admins_meal_sets_path(@meal_set), notice: '食材セットを更新しました'
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
    # TODO: rails8のexceptにしたい
    params.require(:meal_set).permit(
      :name,
      :description,
      meal_set_items_attributes: %i[id meal_id quantity _destroy]
    )
  end
end
