class Book
  def to_s
    %("#{title}", by #{author})
  end

  attr_accessor :title, :author
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
