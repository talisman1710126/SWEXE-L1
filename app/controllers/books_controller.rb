class BooksController < ApplicationController
  # 一覧
  def index
    @books = Book.all
  end

  # 詳細
  def show
    @book = Book.find(params[:id])
  end

  # 新規作成フォーム
  def new
    @book = Book.new
  end

  # 作成処理
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book        # 保存できたら詳細ページへ
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 編集フォーム
  def edit
    @book = Book.find(params[:id])
  end

  # 更新処理
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  # 受け取ってよいパラメータを絞る（Strong Parameters）
  def book_params
    params.require(:book).permit(:title, :author, :published_year)
  end
end