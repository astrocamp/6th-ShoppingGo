# frozen_string_literal: true

class ProductsController < ApplicationController

  def index
      if params[:search]
          @products = Product.where('name LIKE ?OR content LIKE ?', "%#{params[:search]}%",  "%#{params[:search]}%")
      else
          @product = Product.all
      end
  end 

  def new
    @product = Product.new
    render layout: "store"
  end
  
  def show
    @product = Product.find(params[:id])
  end 
  
  def create
    @product = Product.new(product_params)
    @product.shop = current_user.shop
    if @product.save
      redirect_to shops_path, notice: '新增商品成功'
    else
      render :new, notice: '沒成功，再試一次吧'
    end
  end

  def edit
    find_product
  end

  def update
    find_product
    if @product.update(product_params)
      redirect_to shops_path, notice: '更新商品成功'
    else
      render :edit, notice: '更新商品失敗'
    end
  end

  def destroy
    find_product
    if @product.destroy
      redirect_to shops_path, notice: '已刪除商品'
    else
      redirect_to shops_path, notice: '刪除商品失敗'
    end
  end

  def search
  end

  private
  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:image, :name, :content, :quantity, :price, {images:[]})
  end
end
