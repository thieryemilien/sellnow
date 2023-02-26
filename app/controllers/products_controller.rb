class ProductsController < ApplicationController
    #las clases se declaran en formato de camelcase
        
    def index
        #consulta a la base datos que nos devuelva todos los productos
        #@products con la arroba adelante significa que es una variable de instancia, 
        #por lo cual podrá ser leida en la plantilñla de la vista 
        
        
        #@products = Product.all 
        #para evitar el n+1 query (n plus one query), es decir por cada product se hace consultas 
        #independiente para obtener las photos en las tablas correspondientes  
        @products = Product.all.with_attached_photo
    end

    def show
        #params[:id] obtner el parametro
        #@product = Product.find(params[:id])
        get_product
    end

    def new 
        @product = Product.new
    end

    #save product
    def create 
        @product = Product.new(product_params)

        #mostrar por pantalla el contenido de una variable
        #pp @product;
        
        if @product.save
            #notice se guardara en una variable que se llama flash, y esa vaiable estara disponible en la siguiente peticion
            #se usa notice cuando el mensaje es satisfactorio y alert cuando es un error 
            redirect_to products_path, notice: t('.msg_created')
        else
            #retorna a la vista un codigo 422
            render :new, status: :unprocessable_entity 
        end
    end

    def edit 
        #@product = Product.find(params[:id])
        get_product
    end

    def update 
        #variable de tipo instancia
        #@product = Product.find(params[:id])
        get_product

        if @product.update(product_params)
            redirect_to products_path, notice: t('.msg_updated')
        else
            render :edit, status: :unprocessable_entity
            # o render :edit, status: 422
        end
    end

    def destroy 
       #@product = Product.find(params[:id])
       get_product #llamamos al metodo get_product para obtener un producto
       @product.destroy

       redirect_to products_path, notice: t('.msg_deleted'), status: :see_other
    end

    private 
    def product_params
        
        #extraer el objeto product y permitir que solo estos atributos se inserten en la base datos
        params.require(:product).permit(:title, :description, :price, :photo)
    end

    #metodo que retorna un producto,  en ruby es implicito el return
    def get_product 
        @product = Product.find(params[:id])
    end

end