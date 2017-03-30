class Goal < ActiveRecord::Base
  include AASM

  belongs_to :user

  aasm do
    after_all_events :log_status_change

    state :free, initial: true
    state :applying, after_exit: :thank_user_for_applying
    state :triage, after_enter: :notify_triage_required
    state :ongoing

    event :apply_to_managed, success: :track_user_started_application do
      transitions from: :free, to: :applying
    end

    event :flag_for_triage, success: :track_user_application_triage do
      transitions from: :applying, to: :triage
    end

    event :complete_application, success: :track_user_application_completed do
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

  def notify_triage_required
    Task.create(description: "Follow up with user #{user.id} in triage", assigned_to: 'enrollment', due_at: 1.day.from_now)
  end

  def log_status_change
    Rails.logger.info "#{DateTime.now.iso8601}: Goal #{id} changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end

  def track_user_started_application
    user.activities.create(public_details: 'Started Application', happened_at: DateTime.now)
  end

  def track_user_application_completed
    user.activities.create(public_details: 'Finished Application', happened_at: DateTime.now)
  end

  def track_user_application_triage
    user.activities.create(public_details: 'Finished Application', private_details: 'Finished Application (triage required)', happened_at: DateTime.now)
  end

  def thank_user_for_applying
    UserMailer.thanks_for_applying_email(user).deliver
  end
end
