json.extract! task_recipe, :id, :event, :description, :due_at, :assigned_to, :created_at, :updated_at
json.url task_recipe_url(task_recipe, format: :json)
