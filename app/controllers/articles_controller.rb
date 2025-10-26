class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id]) #データベースから記事を取得。before_actionがあるためこの行はなくても機能する
  end

  def new
    @article = Article.new #空の新しいArticleオブジェクトを作成
  end

  def create
    @article = Article.new(article_params) #フォームデータで新しいオブジェクト作成
    
    if @article.save #データベースに保存を試行
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity #失敗時はフォーム再表示
    end
    #newアクション = フォーム表示
    #createアクション = データ保存 この2つの処理で新規作成機能の実装！
  end



  def edit
    @article = Article.find(params[:id]) #@articleインスタンス変数に格納が行われている
  end

  def update
    # 画像削除のチェックボックスがチェックされている場合の処理
    # params[:article][:remove_image]が'1'（チェックされた状態）の場合に実行
    if params[:article] && params[:article][:remove_image] == '1'
      @article.image.purge  # 既存の画像をActive Storageから完全に削除
    end
    
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully deleted.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    # :remove_image を追加（画像削除チェックボックスの値を受け取るため）
    params.require(:article).permit(:title, :body, :image, :remove_image)
  end
end