class PaginationService
  # Inicializa el servicio de paginación
  # Params:
  #   collection: ActiveRecord::Relation - La colección de registros a paginar
  #   page_params: Hash - Parámetros de paginación (page y per_page)
  def initialize(collection, page_params)
    @collection = collection
    @page = (page_params[:page] || 1).to_i
    @per_page = (page_params[:per_page] || 10).to_i
  end

  # Aplica la paginación a la colección
  # Retorna: ActiveRecord::Relation - La colección paginada
  def paginate
    @collection.page(@page).per(@per_page)
  end
end