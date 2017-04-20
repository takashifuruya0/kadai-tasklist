class TasklistsController < ApplicationController
	before_action :set_tasklist, only: [:show,:edit,:update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @tasklists = Tasklist.all.page(params[:page]).per(10)
  end

  def show
  end

	def new
		@tasklist = Tasklist.new
	end

	def create
		@tasklist = current_user.tasklists.build(tasklist_params)
		
		if @tasklist.save
			flash[:success] = "Tasklist が正常に登録されました"
			redirect_to root_url
		else
			@tasklists = current_user.tasklists.order("created_at DESC").page(params[:page])
			flash.now[:danger] = "Tasklist が登録されませんでした"
			render "toppages/index"
		end
	end

	def edit
	end
	
	def destroy
		@tasklist.destroy
		
		flash[:success] = "Task は正常に削除されました"
		redirect_to tasklists_url
	end

	def update
		if @tasklist.update(tasklist_params)
			flash[:success] = "タスクは正常に登録されました"
			redirect_to @tasklist
		else
			flash.now[:danger] = "タスクは登録されませんでした"
			render :edit
		end
	end

	private
	# Strong 
	def tasklist_params
		params.require(:tasklist).permit(:content, :status)
	end
	
	def set_tasklist
		@tasklist = Tasklist.find(params[:id])
	end
	
	def correct_user
		@tasklist = curryent_user.tasklists.find_by(id: params[:id])
		unless @tasklist
			redirect_to root_path
		end
	end
end