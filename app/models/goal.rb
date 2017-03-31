class Goal < ActiveRecord::Base
  include AASM

  belongs_to :user

  aasm do
    after_all_events [:create_event_tasks, :log_status_change]

    state :free, initial: true
    state :applying, after_exit: :thank_user_for_applying
    state :triage
    state :ongoing

    event :begin_application, success: :begin_application_success do
      transitions from: :free, to: :applying
    end

    event :flag_for_triage, success: :flag_for_triage_success do
      transitions from: :applying, to: :triage
    end

    event :complete_application, success: :complete_application_success do
      transitions from: :applying, to: :ongoing
    end

    event :resolve_triage do
      transitions from: :triage, to: :ongoing
    end

    event :quarterly_rebalance do
      transitions from: :ongoing, to: :ongoing
    end

    event :cancel_application do
      transitions from: :applying, to: :free
      transitions from: :triage, to: :free
      transitions from: :ongoing, to: :free
    end
  end

  private

  def create_event_tasks
    event_name = aasm.current_event.to_s.gsub(/\!$/, '')
    recipes_for_event = TaskRecipe.where(event: event_name)
    recipes_for_event.each { |recipe| recipe.create_task }
  end

  # Create user activities on transition
  def begin_application_success
    user.activities.create(public_details: 'Started Application', happened_at: DateTime.now)
  end

  def complete_application_success
    user.activities.create(public_details: 'Finished Application', happened_at: DateTime.now)
  end

  def flag_for_triage_success
    user.activities.create(public_details: 'Finished Application', private_details: 'Finished Application (triage required)', happened_at: DateTime.now)
  end

  # E-mail users on event
  def thank_user_for_applying
    UserMailer.thanks_for_applying_email(user).deliver
  end


  def log_status_change
    Rails.logger.info "#{DateTime.now.iso8601}: Goal #{id} changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end
end
