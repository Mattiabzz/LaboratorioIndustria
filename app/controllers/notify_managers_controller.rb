class NotifyManagersController < ApplicationController
  before_action :set_notify_manager, only: %i[ show edit update destroy ]

  # GET /notify_managers or /notify_managers.json
  def index
    @notify_managers = NotifyManager.all
  end

  # GET /notify_managers/1 or /notify_managers/1.json
  def show
  end

  # GET /notify_managers/new
  def new
    @notify_manager = NotifyManager.new
  end

  # GET /notify_managers/1/edit
  def edit
  end

  # POST /notify_managers or /notify_managers.json
  def create
    @notify_manager = NotifyManager.new(notify_manager_params)

    respond_to do |format|
      if @notify_manager.save
        format.html { redirect_to notify_manager_url(@notify_manager), notice: "Notify manager was successfully created." }
        format.json { render :show, status: :created, location: @notify_manager }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notify_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notify_managers/1 or /notify_managers/1.json
  def update
    respond_to do |format|
      if @notify_manager.update(notify_manager_params)
        format.html { redirect_to notify_manager_url(@notify_manager), notice: "Notify manager was successfully updated." }
        format.json { render :show, status: :ok, location: @notify_manager }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notify_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notify_managers/1 or /notify_managers/1.json
  def destroy
    @notify_manager.destroy!

    respond_to do |format|
      format.html { redirect_to notify_managers_url, notice: "Notify manager was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def notifiche_manager
    manager = Manager.find(params[:manager_id])

    @notifiche_nuove = manager.notify_managers.where(letto: false).to_a.dup

    @notifiche_vecchie = manager.notify_managers.where(letto: true)

    manager.notify_managers.where(letto: false).update_all(letto: true)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notify_manager
      @notify_manager = NotifyManager.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notify_manager_params
      params.require(:notify_manager).permit(:manager_id, )
    end
end
