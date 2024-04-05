class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  #before_action :set_current_manager
  before_action :require_user,only: [:ricerca_eventi]
  before_action :require_manager,only: [:ispeziona_eventi,:edit,:create,:new]
  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    #@current_manager.events.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    m = Manager.find(session[:manager_id])
    #puts " valore di current manager valido tramite find=> #{m.valid?}"
    #puts " valore ID di current manager tramite find=> #{m.id}"

    event_params_with_additional_values = event_params.merge(manager_id: m.id)
    #puts "valore di params mergati => #{event_params_with_additional_values}"
    @event = Event.new(event_params_with_additional_values)
    #@event.manager_id = @current_manager.id
    e = m.events.build(event_params)
    puts "event risulta valido? => #{e.valid?}"
    puts "erroe => #{e.errors.full_messages}"
    puts
    #puts " valore di manager_id in event=> #{@event.manager_id}"
    #puts " valore di current @manager in event=> #{@manager.events.build(event_params)}"
    #puts "valore di @event dopo manager-id => #{@e = @manager.events.}"
    respond_to do |format|
      if @event.save
        format.html { redirect_to manager_dashboard_path, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to manager_dashboard_path, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to manager_dashboard_path, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def ricerca_eventi

    u = User.find(session[:user_id])
    
    if params[:search].present?
      @events = Event.where("capacita_corrente < capacita AND nome LIKE ? OR descrizione LIKE ? OR luogo LIKE ? OR citta LIKE ? OR via LIKE ?" ,"%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%").where.not(id: u.reservations.pluck(:event_id))
    else
      @events = Event.where("capacita_corrente < capacita ").where.not(id: u.reservations.pluck(:event_id))
    end
    #@events = @events.where("title LIKE ? OR description LIKE ? OR location LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
  end

  # def set_current_manager
  #   @current_manager = Manager.find(session[:manager_id])
  # end
def ispeziona_eventi
 #puts "sono in ispeziona eventi"
 id = params[:event_id]
 #puts "ho trovoato questo parametro con event_id => #{id}"
 @e = Event.find(id)

 @reservations = @e.reservations.includes(:user)
 #puts "valore di  @e => #{@users}"

end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:nome, :descrizione, :data_inizio, :data_fine, :luogo, :capacita, :citta, :via)
    end
end
