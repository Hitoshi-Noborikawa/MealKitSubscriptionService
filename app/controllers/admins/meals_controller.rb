class Admins::MealsController < Admins::ApplicationController
  before_action :set_meal, only: %i[edit update destroy]

  def index
    @meals = Meal.default_order
  end

  def new
    @meal = Meal.new
  end

  def edit; end;

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      redirect_to admins_meals_path, notice: '食材を作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @meal.update(meal_params)
      redirect_to admins_meals_path, notice: '食材を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal.destroy!
    redirect_to meals_path, notice: '食材を削除しました'
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.expect(meal: %i[name refrigeration])
  end
end
