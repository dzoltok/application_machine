class Goal < ActiveRecord::Base
  include AASM

  belongs_to :user

  aasm do
    state :free, initial: true
    state :applying, :triage, :ongoing

    event :apply_to_managed do
      transitions from: :free, to: :applying
    end

    event :flag_for_triage do
      transitions from: :applying, to: :triage
    end

    event :complete_application do
      transitions from: :applying, to: :ongoing
    end

    event :resolve_triage do
      transitions from: :triage, to: :ongoing
    end

    event :quarterly_rebalance do
      transitions from: :ongoing, to: :ongoing
    end
  end

end
