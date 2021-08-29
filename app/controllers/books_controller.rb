class BooksController < ApplicationController
  before_action :hensyu, only: [:edit,:update]

  def new
    @book =Book.new
  end

  def index
    @books =Book.all
    @book =Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @user = current_user
    @book.user_id = current_user.id

    if @book.save
       flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end

  end

  def edit
    @book = Book.find(params[:id])

  end

  def update
    @book = Book.find(params[:id])


    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)

    else
      render :edit
    end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def hensyu
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end