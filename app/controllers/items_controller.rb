class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :buy, :edit, :update, :destroy,]
  before_action :set_item, only: [:show, :edit, :update, :destroy, :buy, :stop, :start]
  require 'enumerize'
  require "payjp"

  def show
    if Category.find(@item.category_id).parent.parent
      @subsubcategory = Category.find(@item.category_id)
      @subcategory = @subsubcategory.parent
      @category = @subcategory.parent
    else
      @subcategory = Category.find(@item.category_id)
      @category = @subcategory.parent
    end
    @brand = Brand.find(@item.brand_id_before_type_cast)
    @user = User.find(@item.seller_id)
    # 以下、imgテーブル作成次第表示----------------
    # @img = Item_imag.find(item_id: params[:id])
  end

  def new
    @item = Item.new
    @item.item_imgs.new
    @category =  Category.where(parent_id: nil).pluck(:name).unshift("---")
  end

  def get_subcategory
    # 選択された大カテゴリーに紐付く中カテゴリーの配列を取得
    @subcategory = Category.find_by(name: "#{params[:category]}", parent_id: nil).children
  end

  # 中カテゴリーが選択された後に動くアクション
  def get_subsubcategory
    @subsubcategory = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    # 開発終わればsave!をsaveに戻す
    if @item.save!
      redirect_to @item
    else
      render :new
    end
  end

  def edit
    @category =  Category.where(parent_id: nil).pluck(:name).unshift("---")
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def buy
    @address = Address.find_by(user_id: current_user.id)

    card = Card.where(user_id: current_user.id).first
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end


  def stop
    @item.update_attribute(:trade_step, "出品停止")
    redirect_to @item
  end

  def start
    @item.update_attribute(:trade_step, "出品中")
    redirect_to @item
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def change_params
    params.require(:item).permit(:trade_step)
  end
  
  def item_params
    params.require(:item).permit(:name, :size, :price, :seller_id, :brand_id, :category_id, :status, :charge, :trade_step, :delivery, :prefecture, :term, :item_text, item_imgs_attributes: [:img, :_destroy, :id]).merge(seller_id:current_user.id)
  end


end
