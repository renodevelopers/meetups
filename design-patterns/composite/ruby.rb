module DesignPatterns
  module Structural
    module Composite
      class FormElement
        def render(indent)
          raise NotImplementedError
        end
      end

      class Form < FormElement
        attr_reader :elements

        def initialize
          @elements = []
        end

        def render(indent = 0)
          elements.inject('') do |result, element|
            result + element.render(indent + 1)
          end
        end

        def add_element(element)
          elements.push(element)
        end
      end


      class InputElement < FormElement
        def render(indent = 0)
          "#{ Array.new(indent) { ' ' }.join }<input type='text' />"
        end
      end

      class TextElement < FormElement
        def render(indent = 0)
          "#{ Array.new(indent) { ' ' }.join }.this is a text element."
        end
      end

      if $0 == __FILE__
        require 'rspec/autorun'

        RSpec.describe 'test composite pattern on form' do
          it 'renders the form correctly' do
            form = Form.new
            form.add_element(TextElement.new)
            form.add_element(InputElement.new)
            embed = Form.new
            embed.add_element(TextElement.new)
            embed.add_element(InputElement.new)
            form.add_element(embed)
            expect(form.render).to eq('')
          end
        end
      end
    end
  end
end
