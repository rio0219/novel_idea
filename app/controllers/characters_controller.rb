class CharactersController < ApplicationController
  before_action :set_work
  before_action :set_character, only: [ :edit, :update, :destroy ]

  def index
    @work = Work.find(params[:work_id])
    @characters = @work.characters
  end

  def new
    @character = @work.characters.build
  end

  def create
    @character = @work.characters.build(character_params)
    if @character.save
      redirect_to work_characters_path(@work), notice: "キャラクターを作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @character.update(character_params)
      redirect_to work_characters_path(@work), notice: "キャラクターを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @character.destroy
    redirect_to work_characters_path(@work), notice: "キャラクターを削除しました"
  end

  private

  def set_work
    @work = Work.find(params[:work_id])
  end

  def set_character
    @character = @work.characters.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name, :age, :gender, :hair_color, :eye_color, :physique, :others, :personality, :background)
  end
end
