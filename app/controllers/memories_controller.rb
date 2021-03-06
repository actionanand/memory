class MemoriesController < ApplicationController
  before_action :set_memory, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # GET /memories
  # GET /memories.json
  def index
    @memories = Memory.all
  end

  # GET /memories/1
  # GET /memories/1.json
  def show
  end

  # GET /memories/new
  def new
    @memory = Memory.new
  end

  # GET /memories/1/edit
  def edit
  end

  # POST /memories
  # POST /memories.json
  def create
    @memory = Memory.new(memory_params)
    @memory.user_id = current_user.id

    respond_to do |format|
      if @memory.save
        format.html { redirect_to @memory, notice: 'Memory was successfully created.' }
        format.json { render :show, status: :created, location: @memory }
        format.js
      else
        format.html { render :new }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /memories/1
  # PATCH/PUT /memories/1.json
  def update
    respond_to do |format|
      if @memory.update(memory_params)
        format.html { redirect_to @memory, notice: 'Memory was successfully updated.' }
        format.json { render :show, status: :ok, location: @memory }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /memories/1
  # DELETE /memories/1.json
  def destroy
    @memory.destroy
    respond_to do |format|
      format.html { redirect_to memories_url, notice: 'Memory was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end
  
  def like
    session[:return_to] ||= request.referer
    @memory.liked_by current_user
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to) }
      format.js
    end
  end
 
  def unlike
    session[:return_to] ||= request.referer
    @memory.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to) }
      format.js
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memory
      @memory = Memory.find(params[:id])
    end
    
    def require_same_user
      if current_user != @memory.user
        flash[:warning] = "You can edit or delete your own articles only"
        redirect_to root_path
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def memory_params
      params.require(:memory).permit(:title, :body)
    end
end
