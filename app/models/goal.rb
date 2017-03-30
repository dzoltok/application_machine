class Goal < ActiveRecord::Base
  include AASM

  belongs_to :user

  aasm do
    after_all_transitions :log_status_change

    state :free, initial: true
    state :applying
    state :triage, enter: :notify_triage_required
    state :ongoing

    event :apply_to_managed do
      transitions from: :free, to: :applying, success: :track_user_started_application
    end

    event :flag_for_triage do
      transitions from: :applying, to: :triage, success: :track_user_application_triage
    end

    event :complete_application do
      transitions from: :applying, to: :ongoing, success: :track_user_application_completed
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
    UserActivity.create(user: user, happened_at: DateTime.now, public_details: 'Started Application')
  end

  def track_user_application_completed
    UserActivity.create(user: user, happened_at: DateTime.now, public_details: 'Finished Application')
  end

  def track_user_application_triage
    UserActivity.create(user: user, happened_at: DateTime.now, public_details: 'Finished Application', private_details: 'Finished Application (triage required)')
  end

end
