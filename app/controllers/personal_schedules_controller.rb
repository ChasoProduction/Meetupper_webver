class PersonalSchedulesController < ApplicationController
  before_action :logged_in_user, only:[:create, :update, :destroy, :edit]
  before_action :is_mine?, only:[:update, :destroy, :edit]

  def create
    @schedule = current_user.personal_schedules.build(schedule_params)
    if @schedule.save
      flash[:success] = '登録完了!'
      redirect_to root_url
    else
      #@user = current_user
      #@personal_schedules = @user.personal_schedules.all.order('starts_at, importance')
      #render 'users/show'
      redirect_to user_url(current_user), flash: { error:@schedule.errors.full_messages }
    end
  end

  def edit
  end

  def update
    if @schedule.update_attributes(schedule_params)
      flash[:info] = '更新完了!'
      redirect_to root_url
    else
      redirect_to edit_personal_schedule_url(@schedule), flash: { error:@schedule.errors.full_messages }
    end
  end

  def destroy
    @schedule.destroy
    flash[:success] = '削除完了!'
    redirect_to user_url(current_user)
  end

  private
    def schedule_params
      params.require(:personal_schedule).permit(:content, :starts_at, :ends_at, :importance)
    end

    def is_mine?
      @schedule = PersonalSchedule.find(params[:id])
      @user = User.find(@schedule.user_id)
      unless current_user.id == @user.id
        flash[:danger] = '他人の予定いじるなや!'
        redirect_to user_url(current_user)
      end
    end
end
