class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id #dato che non passo nulla crea la sessione per id post salvtaggio
        format.html { redirect_to user_dashboard_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_dashboard_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def dashboard
    # Assumi che tu abbia un metodo per recuperare il manager attualmente connesso
    @u = User.find_by(id: session[:user_id]) if session[:user_id]

    @notifiche =  @u.notify_users.where(letto: 'false').size

    @reservations = @u.reservations.includes(:event)
    
 end

  #metodo che viene reso disponibile nelle view
  helper_method :current_user
  #recupero informazioni utente
  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end


  #login per l'utente
  # def login
  #   puts "Hai raggiunto il metodo login!"
    
  #   @user = User.find_by(email: params[:email])

  #   if @user && @user.password == params[:password]
  #     # Utente autenticato con successo
  #     # Puoi impostare una sessione per mantenere l'utente autenticato
  #     session[:user_id] = @user.id

  #     logger.info "Utente autenticato con successo: #{@user.id}"
  #     redirect_to user_dashboard_path, notice: "loggato"# Reindirizza all'area riservata
  #   else
  #     flash[:error] = "Credenziali non valide"
  #     redirect_to root_path # Reindirizza nuovamente alla homepage
  #   end
  # end

 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:nome, :cognome, :email, :eta, :codice_fiscale, :password)
    end
end
