class MagicCardsController < ApplicationController
  def show
    @card = MagicCard.find_by(id: params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @card}
    end
  end

  def index
    @cards = []
    MagicCard.select(
      :id,
      :image_uris,
      :name,
      :set,
      :set_name,
      :mana_cost,
      :type_line,
      :oracle_text,
      :power,
      :toughness
    ).where.not(multiverse_ids: []).order(Arel.sql("CAST(multiverse_ids[1] AS INT)")).find_in_batches(batch_size: 5000) do |batch|
      @cards += batch
    end
    # MagicCard.where(multiverse_ids: [])
    @pagy, @magic_cards = pagy_array(@cards, items: 10)
    respond_to do |format|
      format.html { render :index }
      format.json { render json: MagicCard.all, include: '*.*'}
    end
  end
end
