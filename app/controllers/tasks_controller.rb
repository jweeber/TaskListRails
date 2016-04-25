class TasksController < ApplicationController
	def index
		@task_list = Task.where(completed_at: nil)
	end

# clicking on title shows all tasks with that title, even ones that are completed. Fix this.
	def show
		# @task_list = Task.where.not(completed_at: nil)
		@task_list = Task.where(title: params[:title])
		render :index
	end

	def new
		@task = Task.new
		@person = Person.new
	end

	def show_completed
		@task_list = Task.where.not(completed_at: nil)
		render :show
	end

	def travelers
	end

	def create
		@task = Task.create(task_create_params[:task])
		redirect_to root_path
	end

	def edit
		@edit = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		@task.update_attributes(task_update_params[:task])
		redirect_to root_path
	end

	def completed
		@task = Task.find(params[:id])
		@task.completed_at = DateTime.now
		@task.save
		show_completed
	end


	def delete
	Task.find(params[:id]).destroy
   redirect_to root_path
	end

	private

	def task_create_params
		params.permit(task: [:title, :description, :person_id])
	end

	def task_update_params
		params.permit(task: [:title, :description, :person_id])
	end

	def people_create_params
		params.permit(person: [:name])
		
	end


end

