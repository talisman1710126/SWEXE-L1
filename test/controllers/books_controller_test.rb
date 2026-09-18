require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "root path shows the book index" do
    get "/"
    assert_response :success
    assert_select "h1", /所有本リスト/
  end

  test "can create, update, and destroy a book" do
    post books_path, params: {
      book: {
        title: "Ruby on Rails入門",
        author: "山田太郎",
        published_year: 2024
      }
    }
    assert_redirected_to book_path(Book.last)

    book = Book.last
    get edit_book_path(book)
    assert_response :success

    patch book_path(book), params: {
      book: {
        title: "Rails実践ガイド",
        author: "山田太郎",
        published_year: 2025
      }
    }
    assert_redirected_to book_path(book)
    assert_equal "Rails実践ガイド", book.reload.title

    delete book_path(book)
    assert_redirected_to books_path
    assert_nil Book.find_by(id: book.id)
  end
end
