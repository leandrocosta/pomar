class Task < ActiveRecord::Base
  belongs_to :project

  scope :TODOs, where("tasks.project_id IS NULL")
end
