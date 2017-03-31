class TaskRecipe < ActiveRecord::Base
  TASK_CATEGORIES = [
    'Enrollment',
    'Trading',
    'Premium',
  ]

  def build_task(options = {})
    Task.build(params_for_task(options))
  end

  def create_task(options = {})
    Task.create(params_for_task(options))
  end

  private

  def params_for_task(options = {})
    Rails.logger.debug(options)
    {
      description: I18n.interpolate(description, options[:description_params]),
      due_at: days_before_due.days.from_now,
      assigned_to: ops_user_for_category,
    }
  end

  def ops_user_for_category
    case category_name
      when 'Enrollment' then 'Sarah'
      when 'Trading' then 'Gary'
      when 'Premium' then 'Maria'
    end
  end
end
