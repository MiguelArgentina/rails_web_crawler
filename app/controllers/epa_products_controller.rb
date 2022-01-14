class EpaProductsController < ApplicationController
  before_action :set_epa_product, only: %i[ show edit update destroy ]

  # GET /epa_products or /epa_products.json
  def index
    @epa_products = EpaProduct.all
  end

  # GET /epa_products/1 or /epa_products/1.json
  def show
  end

 def scrape
  [1..1].each do |index|
    url = 'https://cr.epaenlinea.com/acabados.html' + "?p=#{index.to_s}"
    response = EpaLinksSpider.process(url)
  end
  
  url_array = %w[
    https://cr.epaenlinea.com/acabados.html
    https://cr.epaenlinea.com/automotriz.html
    https://cr.epaenlinea.com/categorias/banos.html
    https://cr.epaenlinea.com/construccion.html
    https://cr.epaenlinea.com/decoracion.html
    https://cr.epaenlinea.com/ferreteria.html
    https://cr.epaenlinea.com/herramientas.html
    https://cr.epaenlinea.com/hogar.html
    https://cr.epaenlinea.com/categorias/iluminacion.html
    https://cr.epaenlinea.com/jardin.html
    https://cr.epaenlinea.com/categorias/lamparas.html
    https://cr.epaenlinea.com/maderas.html
    https://cr.epaenlinea.com/pintura.html
    https://cr.epaenlinea.com/categorias/mascotas2702202010523.html
    https://cr.epaenlinea.com/electrodomesticos.html
  ]

  if response[:status] == :completed && response[:error].nil?
    flash.now[:notice] = "Webpage scrapped correctly"
  else
    flash.now[:alert] = response[:error]
  end
  rescue StandardError => e
    flash.now[:alert] = "Error: #{e}"
  end

  # GET /epa_products/new
  def new
    @epa_product = EpaProduct.new
  end

  # GET /epa_products/1/edit
  def edit
  end

  # POST /epa_products or /epa_products.json
  def create
    @epa_product = EpaProduct.new(epa_product_params)

    respond_to do |format|
      if @epa_product.save
        format.html { redirect_to epa_product_url(@epa_product), notice: "Epa product was successfully created." }
        format.json { render :show, status: :created, location: @epa_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @epa_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /epa_products/1 or /epa_products/1.json
  def update
    respond_to do |format|
      if @epa_product.update(epa_product_params)
        format.html { redirect_to epa_product_url(@epa_product), notice: "Epa product was successfully updated." }
        format.json { render :show, status: :ok, location: @epa_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @epa_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /epa_products/1 or /epa_products/1.json
  def destroy
    @epa_product.destroy

    respond_to do |format|
      format.html { redirect_to epa_products_url, notice: "Epa product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_epa_product
      @epa_product = EpaProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def epa_product_params
      params.require(:epa_product).permit(:name, :price, :product_dimensions, :package_dimensions, :need_assembly)
    end
end
