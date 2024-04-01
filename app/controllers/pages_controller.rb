class PagesController < ApplicationController
  def index
    
  end

def new

end


  def login
    @user = User.find_by(email: params[:email])
    @manager = Manager.find_by(email: params[:email])

    if @user && @user.password == params[:password]
      # L'utente è stato trovato nella tabella User e la password è corretta
      session[:user_id] = @user.id
      redirect_to user_dashboard_path, notice: "Login effettuato come utente."

    elsif @manager && @manager.password == params[:password]
      # Il manager è stato trovato nella tabella Manager e la password è corretta
      session[:manager_id] = @manager.id
      redirect_to manager_dashboard_path, notice: "Login effettuato come manager."
    else
      # Nessun utente o manager trovato con le credenziali fornite o la password non è corretta
      if @user.nil? && @manager.nil?
        flash[:error] = "Email non valida."
        #redirect_to root_path
      else
        flash[:error] = "password non valida."
       
      end
      puts flash.inspect
      redirect_to root_path
    end
  end






end
