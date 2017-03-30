class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :fire_event]

  # GET /goals/1
  # GET /goals/1.json
  def show
  end

  # POST /goals/1/fire_event
  # POST /goals/1/fire_event.json
  def fire_event
    event = fire_event_params[:event]
    Rails.logger.info "running fire_event on #{event}"
    @goal.send(event)
    @goal.save!
    redirect_to @goal.user
  end





  private
  # Use callbacks to share common setup or constraints between actions.
  def set_goal
    @goal = Goal.find(params[:id])
  end

  # # Never trust parameters from the scary internet, only allow the white list through.
  # def user_params
  #   params.require(:user).permit(:email_address)
  # end

  def fire_event_params
    params.require(:goal).permit(:event)
  end
end
