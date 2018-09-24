require 'date'

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find(task_id)
    if @task.nil?
      head :not_found
    end
  end

  def new
    @task = Task.new
  end

  def create
    filtered_task_params = task_params()
    @task = Task.new(filtered_task_params)

    is_successful_save = @task.save
    if is_successful_save
      redirect_to root_path
    else
      render :new
    end

  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)

    redirect_to task_path(task.id)
  end

  def complete
    task = Task.find(params[:id])
    task.completion_date = DateTime.now
    task.save

    redirect_to root_path
  end


private

  def task_params
    return params.require(:task).permit(
      :name,
      :description,
    )
  end
end
