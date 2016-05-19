Spree::ProductsController.class_eval do
  include Nelou::ProductSorting
  include Nelou::ProductFiltering

  alias_method :old_index, :index

  def index
    old_index # Like calling super: http://stackoverflow.com/a/13806783/73673
    @products = apply_filter_scope(@products.reorder('').send(sorting_scope))
    if params[:keywords].present?
      @designers = Nelou::DesignerLabel.active.with_name_like(params[:keywords]).distinct
    end
  end
end
