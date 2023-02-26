class ApplicationController < ActionController::Base
    #por cada action que se llame o cada peticion que venga se 
    #va llamar al metodo switch_locale
    around_action :switch_locate


    def switch_locate(&action)
        #cambia el idioma en la aplicacion para esta eticion en concreto
        #se le pasa el idioma que tiene el usuario en su navegador
        I18n.with_locale(local_from_header, &action)
    end

    private
    def local_from_header
        request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
end
