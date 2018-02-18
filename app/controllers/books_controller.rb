class BooksController < ApplicationController
	# run the find_book method only for the actions in []
	before_action :find_book, only: [:show, :edit, :update, :destroy]

	def index
		# display all books on index page in descending order
		@books = Book.all.order("created_at DESC")
	end

	def show
        # this code has been refractored to the find_book method below
		# @book = Book.find(params[:id])
	end

	def new
		# the @ denotes an instance variable which are used in views
		# this particular instance variable will be used in new.html.erb view template
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)

		# if the new book is saved successfully, redirect to the root page
		# if not, render the new page again.
		if @book.save
			redirect_to root_path
		else
			render 'new'
		end
	end	

	def edit
	end

	def update
		# if the new book is updated successfully, redirect to the book's show page
		# if not, render the edit page again.
		if @book.update(book_params)
			redirect_to book_path(@book)
		else
			render 'edit'
		end
	end

	def destroy
		# after the book is destroyed, the user is redirected back to the root page
		# because the show page for that book no longer exists
		@book.destroy
		redirect_to root_path
	end

	# book_params is defined in a private method because it will also be used in the update
	# action.
	private

		def book_params
			# require the name of the model & permit the attributes we want
			params.require(:book).permit(:title, :description, :author)
		end

		def find_book
			@book = Book.find(params[:id])
		end

end
