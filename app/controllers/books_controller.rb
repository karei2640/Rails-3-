class BooksController < ApplicationController
 def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     redirect_to "/books/#{@book.id}"
     flash[:notice] = "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
 end
 
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @users = User.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end
  
  def edit
    @book = Book.find (params[:id])
  end
  
 def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    @book.user_id = current_user.id
    redirect_to "/books/#{@book.id}"
    flash[:notice] = "You have updated book successfully."
    else
      render 'books/edit'
    end
 end     
   
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :book_name, :caption, :user_id)
  end
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
