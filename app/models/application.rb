class Application < ActiveRecord::Base
  include AASM

  belongs_to :user

  validates :user_id, presence: true
  validates :goal, presence: true

  aasm do
    after_all_events [:create_event_tasks, :log_status_change]

    state :applying, initial: true
    state :triage
    state :paperwork_sent, after_enter: :paperwork_sent_after_entry
    state :processing
    state :trade_review
    state :trade_ready
    state :cancelled

    event :submit_application, success: :submit_application_success do
      transitions from: :applying, to: :triage, :guard => :triage_required?
      transitions from: :applying, to: :paperwork_sent
    end

    event :send_paperwork, success: :send_paperwork_success do
      transitions from: :triage, to: :paperwork_sent
    end

    event :complete_paperwork, success: :complete_paperwork_success do
      transitions from: :paperwork_sent, to: :processing
    end

    event :flag_for_trade_review do
      transitions from: :processing, to: :trade_review
    end

    event :send_to_trading_team do
      transitions from: :trade_review, to: :trade_ready
    end

    event :cancel, success: :cancel_success do
      transitions from: :applying, to: :cancelled
      transitions from: :triage, to: :cancelled
      transitions from: :paperwork_sent, to: :cancelled
      transitions from: :processing, to: :cancelled
      transitions from: :trade_review, to: :cancelled
      transitions from: :trade_ready, to: :cancelled
    end
  end

  private

  def triage_required?
    false
  end

  def create_event_tasks
    event_name = aasm.current_event.to_s.gsub(/\!$/, '')
    recipes_for_event = TaskRecipe.where(event: event_name)
    recipes_for_event.each { |recipe| recipe.create_task }
  end

  def submit_application_success
    user.activities.create(public_details: 'Submitted Application', happened_at: DateTime.now)
    UserMailer.thanks_for_applying_email(user).deliver
  end

  def paperwork_sent_after_entry
    UserMailer.docusign_sent_email(user).deliver
  end

  def complete_paperwork_success
    user.activities.create(public_details: 'Completed Paperwork', happened_at: DateTime.now)
  end

  def log_status_change
    Rails.logger.info "#{DateTime.now.iso8601}: Application #{id} changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end
end
