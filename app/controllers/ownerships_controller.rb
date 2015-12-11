class OwnershipsController < ApplicationController
  before_action :logged_in_user

  def create
    puts "nekoneko"
    if params[:asin]
      @item = Item.find_or_initialize_by(asin: params[:asin])
    else
      @item = Item.find(params[:item_id])
    end

    # itemsテーブルに存在しない場合はAmazonのデータを登録する。
    if @item.new_record?
      begin
        # TODO 商品情報の取得 Amazon::Ecs.item_lookupを用いてください
        response = Amazon::Ecs.item_lookup(params[:asin], :country => 'jp', :response_group => 'Medium')
        puts response
      rescue Amazon::RequestError => e
        return render :js => "alert('#{e.message}')"
      end

      amazon_item        = response.items.first
      @item.title        = amazon_item.get('ItemAttributes/Title')
      @item.small_image  = amazon_item.get("SmallImage/URL")
      @item.medium_image = amazon_item.get("MediumImage/URL")
      @item.large_image  = amazon_item.get("LargeImage/URL")
      @item.detail_page_url = amazon_item.get("DetailPageURL")
      @item.raw_info     = amazon_item.get_hash
      @item.save!
    end

    # TODO ユーザにwant or haveを設定する
    type = params[:type]
    case type
    when "Have"
      current_user.have(@item)
    when "Want"
      current_user.want(@item)
    end

  end

  def destroy
    @item = Item.find(params[:item_id])

    # TODO 紐付けの解除。 
    type = params[:type]
    case type
    when "Have"
      current_user.unhave(@item)
    when "Want"
      current_user.unwant(@item)
    end

  end
end
