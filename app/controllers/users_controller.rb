class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    #current_user = User.find_by_id(session[:current_user_id])
    @users = User.all
  end
  
  def admin
    @users = User.all
  end
  
  def history
    @histories = History.all
    @histories = History.search(params[:search])  
  end
  
  def user_history
    @user_history = History.all
    @user_history = History.search(params[:name])
  end
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end
  
  def myaccount
    User.find_by(id: session[:user_id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = "Welcome to PetNanny smart Feeding system"
        #redirect_to @user
        #session[:current_user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        #format.html { redirect_to user_path(@user.id), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
        
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        #format.html { redirect_to user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def privacy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password , :email)
    end
end
