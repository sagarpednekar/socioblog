class ArticlesController < ApplicationController
 # before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit,:update,:destroy]
  def index
      @article = Article.paginate(page: params[:page],per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
     @article = Article.new(article_params)
      @article.user = current_user
    if @article.save
       flash[:success] = "Artciles created Succesfully"
      redirect_to article_path(@article)
      else
      render 'new'
    end

    def update
      if @article.update(article_params)
        flash[:success] = "Articles updated Succesfully"
        redirect_to article_path(@article)
        else
        render 'edit'
      end
    end

    def show
      @article = Article.find(params[:id])
    end

    def destroy
      @article.destroy
      flash[:danger] = "Articles succesfully Destroyed "
       redirect_to articles_path
    end


  end

  private
  def set_params
     @article = Article.find(params[:id])
  end


  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can edit your own articles"
        redirect_to root_path      
    end
  end
end
