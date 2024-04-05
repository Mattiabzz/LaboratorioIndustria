class ApplicationController < ActionController::Base
    helper_method :current_user

    private

    def current_user
        puts "chiamata current_user"
       
        @current_user ||= User.find_by(id: session[:user_id])
     
    end


    def current_manager
        puts "chiamata current_manager"

        @current_user ||= Manager.find_by(id: session[:manager_id])

    end

    def require_user
        redirect_to root_path, flash: { error: "Devi effettuare l'accesso come utente per accedere a questa pagina" } if current_user.nil?
    end

    def require_manager
        redirect_to root_path,flash: {  error: "Devi effettuare l'accesso come manager per accedere a questa pagina" } if current_manager.nil?
    end

end
