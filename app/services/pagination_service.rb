class PaginationService
    # Inicializa el servicio de paginación
    # Params:
    #   collection: ActiveRecord::Relation - La colección de registros a paginar
    #   page_params: Hash - Parámetros de paginación (page y per_page)
    # Efecto: 
    #   - Establece la colección a paginar
    #   - Define el número de página actual (por defecto 1)
    #   - Define el número de elementos por página (por defecto 10)
    def initialize(collection, page_params)
      @collection = collection
      @page = page_params[:page] || 1
      @per_page = page_params[:per_page] || 10
    end
  
    # Aplica la paginación a la colección
    # Retorna: ActiveRecord::Relation - La colección paginada
    # Efecto: Utiliza los métodos 'page' y 'per' para paginar la colección
    def paginate
      @collection.page(@page).per(@per_page)
    end
  end