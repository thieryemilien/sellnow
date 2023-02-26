require 'test_helper';  #inluir el codigo de un archivo

class ProductsControllerTest < ActionDispatch::IntegrationTest
    #test de integracion

    #testea que se renderice todos los productos
    test 'render a lsit of products' do
        
        #para ir a la pagina utilizamos el helper de producto que nos devuelve la url
        # products_path es lo mismo que poner '/products'
        get products_path 
    
        assert_response :success
        #de la respuesta busquemos que este los productos que hemos cargado en test/fixtures/products.yml
        #va leer el html y verificar los productos se estan pintando

        #de la clase product esperemos la cantidad de 2 productos 
        assert_select '.product', 2
    end

    #testea que se renderice la pagina de producto
    #test de metodo show product_path es lo mismo que '/product/:id'
    # one es el key del producto en test/fixtures/products.yml 
    test 'render a detail produc page' do
        get product_path(products(:one)) 

        assert_response :success
        assert_select '.title', 'NINTENDO 4'
        assert_select '.description', 'Nuevo de paquete'
        assert_select '.price', '150'
    end

    #test para new product
    test 'render a product form' do
        get new_product_path

        assert_response :success
        assert_select 'form' #que tenga una etiqueta html llmada form
    end

    test 'allow to create a new product' do
        
        post products_path,  params: {
            product: {
                title: 'Ninendo 64',
                description: 'casi nuevo',
                price: 45
            }
        }

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Successfully created...'
        #assert_redirected_to '/products'
    end

    test 'does not allow to create a new product with empty fields' do
        
        post products_path,  params: {
            product: {
                title: '',
                description: 'casi nuevo',
                price: 45
            }
        }

        assert_response :unprocessable_entity
    end

    #test para edit product
    test 'render a edit product form' do
        get edit_product_path(products(:one)) 

        assert_response :success
        assert_select 'form' #que tenga una etiqueta html llmada form
    end

    #test para update(patch) product
    test 'does allow to update a product' do
        
        patch product_path(products(:one)),  params: {
            product: {
                price: 85
            }
        }

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Successfully updated...'
    end


    test 'does not allow to update product with an empty field' do 
        patch product_path(products(:one)),  params: {
            product: {
                price: nil
            }
        }

        assert_response :unprocessable_entity
    end

    test 'can delete products' do 
        #sabemos de antelacion cuantosproductos teniamos antes de hacer la peticion
        assert_difference "Product.count", -1 do
            delete product_path(products(:one))
        end
        
        #al terminar se redirija al listado e productos
        assert_redirected_to products_path
        #esperamos un mensaje de tipo de flash de notice que diga que tu producto se ha eliminado corectamente
        assert_equal flash[:notice], 'Successfully deleted...'
    end

end