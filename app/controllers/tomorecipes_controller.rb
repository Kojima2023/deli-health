class TomorecipesController < ApplicationController

    before_action :authenticate_user!, only: [:new, :edit, :create]

    def search
      @tag_list = Tag.all.sort {|a,b| b.tomorecipes.count <=> a.tomorecipes.count}
      @tag = Tag.find(params[:tag_id])

      if params[:search] != nil && params[:search] != ''
        @tomorecipes = @tag.tomorecipes.where("title LIKE ? ",'%' + params[:search] + '%')
      elsif session[:keyword] == nil || params[:search] == ''
        @tomorecipes = @tag.tomorecipes.all
      else
        @tomorecipes = @tag.tomorecipes.where("title LIKE ? ",'%' + session[:keyword] + '%')
        session[:keyword] = nil
      end
      @tomorecipes = @tomorecipes.page(params[:page]).per(20)
    end
    
    def index
      @tag_list = Tag.all.sort {|a,b| b.tomorecipes.count <=> a.tomorecipes.count}
      if params[:search] == nil
        @tomorecipes = Tomorecipe.all
      elsif params[:search] == ''
        @tomorecipes = Tomorecipe.all
      else
        #部分検索
        @tomorecipes = Tomorecipe.where("title LIKE ? ",'%' + params[:search] + '%')
        session[:keyword] = params[:search]
      end
      @tomorecipes = @tomorecipes.page(params[:page]).per(20)
    end

    #カテゴリー分けに関連するところのみ記載
    def sick
      @tomorecipes = Tomorecipe.where(category:"病気")
      @tag_list = Tag.all.joins(:tomorecipes).where(tomorecipes: {category: "病気"}).uniq.sort {|a,b| b.tomorecipes.count <=> a.tomorecipes.count}
      if params[:search] == nil
        @tomorecipes= @tomorecipes.all
      elsif params[:search] == ''
        @tomorecipes= @tomorecipes.all
      else
        #部分検索
        @tomorecipes = @tomorecipes.where("title LIKE ? ",'%' + params[:search] + '%')
        session[:keyword] = params[:search]
      end
      @tomorecipes = @tomorecipes.page(params[:page]).per(20)
    end

    def allergy
      @tomorecipes = Tomorecipe.where(category:"食物アレルギー・食物不耐症")
      @tag_list = Tag.all.joins(:tomorecipes).where(tomorecipes: {category: "食物アレルギー・食物不耐症"}).uniq.sort {|a,b| b.tomorecipes.count <=> a.tomorecipes.count}
      if params[:search] == nil
        @tomorecipes= @tomorecipes.all
      elsif params[:search] == ''
        @tomorecipes= @tomorecipes.all
      else
        #部分検索
        @tomorecipes = @tomorecipes.where("title LIKE ? ",'%' + params[:search] + '%')
        session[:keyword] = params[:search]
      end
      @tomorecipes = @tomorecipes.page(params[:page]).per(20)
    end

    def weak
      @tomorecipes = Tomorecipe.where(category:"苦手")
      @tag_list = Tag.all.joins(:tomorecipes).where(tomorecipes: {category: "苦手"}).uniq.sort {|a,b| b.tomorecipes.count <=> a.tomorecipes.count}
      if params[:search] == nil
        @tomorecipes= @tomorecipes.all
      elsif params[:search] == ''
        @tomorecipes= @tomorecipes.all
      else
        #部分検索
        @tomorecipes = @tomorecipes.where("title LIKE ? ",'%' + params[:search] + '%')
        session[:keyword] = params[:search]
      end
      @tomorecipes = @tomorecipes.page(params[:page]).per(20)
    end

    def others
      @tomorecipes = Tomorecipe.where(category:"その他または理由なし").or(Tomorecipe.where(category:""))
      @tag_list = Tag.all.joins(:tomorecipes).where(tomorecipes: {category:"その他または理由なし"}).or(Tomorecipe.where(tomorecipes: {category:""})).uniq.sort {|a,b| b.tomorecipes.count <=> a.tomorecipes.count}
      if params[:search] == nil
        @tomorecipes= @tomorecipes.all
      elsif params[:search] == ''
        @tomorecipes= @tomorecipes.all
      else
        #部分検索
        @tomorecipes = @tomorecipes.where("title LIKE ? ",'%' + params[:search] + '%')
        session[:keyword] = params[:search]
      end
      @tomorecipes = @tomorecipes.page(params[:page]).per(20)
    end
    
    def new
        @tomorecipe = Tomorecipe.new
        @tomorecipe = current_user.tomorecipes.new
    end
    
    def create
      tomorecipe = current_user.tomorecipes.new(tomorecipe_params)
      tag_list = params[:tomorecipe][:tag_name].split(nil)

      #tomorecipe.user_id = current_user.id

      if tomorecipe.save
        tomorecipe.save_tag(tag_list)                                                           
        redirect_to :action => "index"
      else
        redirect_to :action => "new"
      end
    end

    def show
      @tomorecipe = Tomorecipe.find(params[:id])
      @tomorecipe_tags = @tomorecipe.tags
    end

    def edit
      @tomorecipe = Tomorecipe.find(params[:id])
      @tag_list = @tomorecipe.tags.pluck(:tag_name).join(nil)
    end

    def update
      tomorecipe = Tomorecipe.find(params[:id])
      tag_list = params[:tomorecipe][:tag_name].split(nil)
      if tomorecipe.update(tomorecipe_params)
        old_relations = TagMap.where(tomorecipe_id: tomorecipe.id)
        old_relations.each do |relation|
         relation.delete
        end
        tomorecipe.save_tag(tag_list)
        redirect_to tomorecipe_path(tomorecipe.id), notice:'投稿完了しました:)'
      else
        redirect_to :action => "edit"
      end

    end

    def destroy
      tomorecipe = Tomorecipe.find(params[:id])
      tomorecipe.destroy
      redirect_to action: :index
    end
  
    private
    def tomorecipe_params
      params.require(:tomorecipe).permit(:title, :image, :image2, :image3, :image4, :video, :ingredient, :recipe, :time, :point, :cost, :user_id, :category)
    end

end
