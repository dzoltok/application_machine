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
    respond_to do |format|
      if @goal.aasm.events.map(&:name).include? event.to_sym
        @goal.send("#{event}!")
        format.html {
          flash[:success] = 'Goal managed state has been updated.'
          redirect_to @goal.user
        }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html {
          flash[:danger] = 'Event is invalid.'
          redirect_to @goal.user
        }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_goal
    @goal = Goal.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def goal_params
    params.require(:goal).permit(:goal_type)
  end

  def fire_event_params
    params.require(:goal).permit(:event)
  end
end
