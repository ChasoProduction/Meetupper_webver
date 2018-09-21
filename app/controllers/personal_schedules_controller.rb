class PersonalSchedulesController < ApplicationController
  before_action :logged_in_user, only:[:create, :update, :destroy]
  before_action :is_mine?, only:[:update, :destroy]

  def create
    @schedule = current_user.personal_schedules.build(schedule_params)
    if @schedule.save
      flash[:success] = '登録完了!'
      redirect_to root_url
    else
      render current_user
    end
  end

  def update
    #まだ
  end

  def destroy
    @schedule.destroy
    flash[:success] = '削除完了!'
    redirect_to user_url(current_user)
  end

  private
    def schedule_params
      params.require(:schedule).permit(:content, :starts_at, :ends_at, :importance)
    end

    def is_mine?
      @schedule = PersonalSchedule.find(params[:id])
      unless current_user.id == @schedule.user_id
        flash[:danger] = '他人の予定いじるなや!'
        redirect_to user_url(current_user)
      end
    end
end
