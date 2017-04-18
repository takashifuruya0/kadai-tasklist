class TasklistsController < ApplicationController
	before_action :set_tasklist, only: [:show,:edit,:update]
  def index
    @tasklists = Tasklist.all
  end

  def show
		@tasklist = Tasklist.find(params[:id])
  end

	def new
		@tasklist = Tasklist.new
	end

	def create
		@tasklist = Tasklist.new(tasklist_params)
		
		if @tasklist.save
			flash[:success] = "Tasklist が正常に登録されました"
			redirect_to @tasklist
		else
			flash.now[:danger] = "Tasklist が登録されませんでした"
			render :new
		end
	end

	def edit
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
end
