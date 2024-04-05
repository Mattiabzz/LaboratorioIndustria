class ManagersController < ApplicationController
  before_action :set_manager, only: %i[ show edit update destroy ]
  before_action :require_manager

  # GET /managers or /managers.json
  def index
    @managers = Manager.all
  end

  # GET /managers/1 or /managers/1.json
  def show
    @events = @current_user.events
  end

  # GET /managers/new
  def new
    @manager = Manager.new
  end

  # GET /managers/1/edit
  def edit
  end

  # POST /managers or /managers.json
  def create
    @manager = Manager.new(manager_params)

    
    #logger.info "Manger reg con successo: #{@manager.id}"
    respond_to do |format|
      if @manager.save
        session[:manager_id] = @manager.id #dato che non passo nulla crea la sessione per id post salvtaggio
        format.html { redirect_to manager_dashboard_path, notice: "Manager was successfully created." }
        format.json { render :show, status: :created, location: @manager }
        #puts "ho creato il record di manger e sono prima del redirect!"
        #redirect_to manager_dashboard_path, notice: "registrazione effettuato come manager."
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
        #render :new
      end
    end
  end

  # PATCH/PUT /managers/1 or /managers/1.json
  def update
    respond_to do |format|
      if @manager.update(manager_params)
        format.html { redirect_to manager_dashboard_path, notice: "Manager was successfully updated." }
        format.json { render :show, status: :ok, location: @manager }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /managers/1 or /managers/1.json
  def destroy
    @manager.destroy!

    respond_to do |format|
      format.html { redirect_to managers_url, notice: "Manager was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def dashboard
     # Assumi che tu abbia un metodo per recuperare il manager attualmente connesso
     @m = Manager.find_by(id: session[:manager_id]) if session[:manager_id]

     @notifiche =  @m.notify_managers.where(letto: 'false').size

     @events = @m.events
     
  end

  #metodo che viene reso disponibile nelle view
  helper_method :current_user
  #recupero informazioni utente
  private
  def current_user
    @current_user ||= Manager.find_by(id: session[:manager_id]) if session[:manager_id]
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manager
      @manager = Manager.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def manager_params
      params.require(:manager).permit(:nome, :cognome, :email, :password)
    end
end
