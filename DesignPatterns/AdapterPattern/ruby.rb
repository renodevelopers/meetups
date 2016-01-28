#
# ruby implementation of
#   https://github.com/domnikl/DesignPatternsPHP/tree/master/Structural/Adapter
# for reno developers meetup 2014-07-28
#   https://github.com/renodevelopers/meetups/issues/26
#


module DesignPatterns
  module Structural
    module Adapter


      # legacy interface (paper)
      class Book
        def open;         'open';        end
        def turn_page;    'turn_page';   end
      end


      # book 2.0 (ebook)
      class Kindle
        def press_next;   'press_next';  end
        def press_start;  'press_start'; end
      end





      class EBookToBookAdapter < Struct.new(:ebook)
        def open
          ebook.press_start
        end

        def turn_page
          ebook.press_next
        end
      end

      if $0 == __FILE__
        require 'test/unit'

        class EBookToBookAdapterTest < Test::Unit::TestCase
          def test
            kindle = Kindle.new
            kindle_book = EBookToBookAdapter.new(kindle)

            assert_equal 'press_start', kindle_book.open
            assert_equal 'press_next', kindle_book.turn_page
          end
        end
      end





    end
  end
end
