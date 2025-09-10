#コントローラーのアクション設定
class ArticlesController < ApplicationController #ApplicationControllerを継承する
  before_action :set_article, only: [:show, :edit, :update, :destroy] #4つのアクションのみを実行できる
  def index
    @articles = Article.all #DBのarticlesテーブルから全レコード取得
    #インスタンス変数に代入（ビューファイルで使用可能）
  end

  def show #詳細表示 before_actionにより既に@articleに該当レコードが設定済み
  end

  def new
    @artcle = Article.new #新しいからのArticleオブジェクトを作成
  end

  def create #フォームから送信されたパラメータで新しいArticleオブジェクトを作成
    @article = Article.new(article_params)
    if @article.save 
      redirect_to @article, notice: 'Article was successflly created.' ##保存成功で詳細ページにリダイレクト
    else
      render :new #失敗時はnew.html.erbを再レンダリング
    end
  end

  def edit
  end #edit.html.erbが自動レンダリングされる

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.' #成功時: 詳細ページにリダイレクト
    else
      render :edit #失敗時: edit.html.erbを再レンダリング（編集フォームの再表示）
    end
  end

  def destroy
    @article.destroy #DBから該当レコードを削除
    redirect_to articles_url, notice: 'Article was succesfully deleted.' #削除後は一覧ページにリダイレクト
  end

  private
#以下は外部から呼び出しできない
  def set_article
    @article = Article.find(params[:id]) #URLパラメータのIDで該当レコードを検索
  end
  def article_params
    params.require(:articele).permit(:title, :body)
  end
end
