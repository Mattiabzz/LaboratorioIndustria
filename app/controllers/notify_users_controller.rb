class NotifyUsersController < ApplicationController
  before_action :set_notify_user, only: %i[ show edit update destroy ]
  before_action :require_user

  # GET /notify_users or /notify_users.json
  def index
    @notify_users = NotifyUser.all
  end

  # GET /notify_users/1 or /notify_users/1.json
  def show
  end

  # GET /notify_users/new
  def new
    @notify_user = NotifyUser.new
  end

  # GET /notify_users/1/edit
  def edit
  end

  # POST /notify_users or /notify_users.json
  def create
    @notify_user = NotifyUser.new(notify_user_params)

    respond_to do |format|
      if @notify_user.save
        format.html { redirect_to notify_user_url(@notify_user), notice: "Notify user was successfully created." }
        format.json { render :show, status: :created, location: @notify_user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notify_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notify_users/1 or /notify_users/1.json
  def update
    respond_to do |format|
      if @notify_user.update(notify_user_params)
        format.html { redirect_to notify_user_url(@notify_user), notice: "Notify user was successfully updated." }
        format.json { render :show, status: :ok, location: @notify_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notify_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notify_users/1 or /notify_users/1.json
  def destroy
    @notify_user.destroy!

    respond_to do |format|
      format.html { redirect_to notify_users_url, notice: "Notify user was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def notifiche_utenti
    utente = User.find(params[:user_id])

    @notifiche_nuove = utente.notify_users.where(letto: false).to_a.dup

    @notifiche_vecchie = utente.notify_users.where(letto: true)

    utente.notify_users.where(letto: false).update_all(letto: true)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notify_user
      @notify_user = NotifyUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notify_user_params
      params.require(:notify_user).permit(:tipo, :user_id)
    end
end
