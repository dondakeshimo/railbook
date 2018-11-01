class HelloController < ApplicationController
  def index
    render plain: 'こんにちは、世界!'
  end

  def view
    @msg = 'Hello, World!'
  end

  def list
      @books = Book.all
  end
end
