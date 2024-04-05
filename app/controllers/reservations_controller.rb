class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]


  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    puts "SONO IN CREATE"
    @reservation = Reservation.new(reservation_params)
    current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

    reservation = current_user.reservations.build(reservation_params)
    reservation.data_prenotazione = Time.zone.now

    puts "time zone now => #{Time.zone.now}"

    #puts "reservaton è valido? #{reservation.valid?}"

    respond_to do |format|
      if reservation.save
        format.html { redirect_to ricerca_eventi_path, notice: "Prenotazione effetuata con successo" }
        format.json { render :show, status: :created, location: @reservation }
      else
        #format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @reservation.errors, status: :unprocessable_entity }
        flash[:error] = 'Ha già un evento in quel intervallo di tempo.'
        #render 'events/ricerca_eventi'
        #puts flash.inspect
        format.html { redirect_to ricerca_eventi_path }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    invocatore = params[:invocatore]

    if invocatore == "manager"
         @reservation.cancellazione_parte_manager = true
    else
         @reservation.cancellazione_parte_utente = true
    end

    @reservation.destroy!

    if invocatore == "manager"
      respond_to do |format|
        format.html { redirect_to ispeziona_eventi_path, notice: "Reservation was successfully destroyed." }
        format.json { head :no_content }
      end

    else
      respond_to do |format|
        format.html { redirect_to user_dashboard_path, notice: "Reservation was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit( :event_id)
    end
end
