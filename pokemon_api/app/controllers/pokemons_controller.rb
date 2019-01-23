class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :update, :destroy]

  def index 
    @pokemon = Pokemon.where(pokemon_query_params)
    render json: @pokemon
  end

  def show 
    render json: @pokemon
  end

  def create 
    @pokemon = Pokemon.create(pokemon_params)
    render json: @pokemon
  end

  def update 
    @pokemon.update_attributes(pokemon_params)
    render json: @pokemon
  end

  def destroy
    @pokemon.destroy 
    render json: { message: "SUCCESS!" }
  end

  private
  def set_pokemon 
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(
      :name, :type1, :type2, :hitpoints, :attack, 
      :defense, :speed, :legendary, :img
    )
  end

  def pokemon_query_params
    params.permit(
      :name, :type1, :type2, :hitpoints, :attack, 
      :defense, :speed, :legendary, :img
    )
  end
end
