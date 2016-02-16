#
# ruby implementation of
#   https://github.com/domnikl/DesignPatternsPHP/tree/master/Structural/Decorator
#

# monkey patch Hash so we don't need xml library
class Hash
  def to_xml
    map do |k, v|
      text = Hash === v ? v.to_xml : v
      "<%s>%s</%s>" % [k, text, k]
    end.join
  end
end


module DesignPatterns
  module Structural
    # Ruby doesn't have interfaces, but this is one way to enforce
    # that classes who mixin a module will respond to a specific message
    module Renderable
      def render_data
        raise NotImplementedError
      end
    end

    class WebService
      include Renderable

      def initialize(data)
        @data = data
      end

      def render_data
        @data
      end
    end

    class Decorator
      include Renderable

      def initialize(wrapped)
        @wrapped = wrapped
      end

      protected
      attr_reader :wrapped
    end

    class RenderInXml < Decorator
      def render_data
        rendered_data = wrapped.render_data
        rendered_data.to_xml
      end
    end

    class RenderInJson < Decorator
      require 'json'

      def render_data
        rendered_data = wrapped.render_data
        rendered_data.to_json
      end
    end

    if $0 == __FILE__
      require 'rspec/autorun'

      RSpec.describe Decorator do
        subject(:service) { WebService.new(foo: 'bar') }

        it 'rendered as json' do
          json_service = RenderInJson.new(service)
          expect(json_service.render_data).to eq('{"foo":"bar"}')
        end

        it 'rendered as xml' do
          xml_service = RenderInXml.new(service)
          expect(xml_service.render_data).to eq('<foo>bar</foo>')
        end

        it 'renderable requires `render_data` to be implemented' do
          class Dummy; include Renderable; end

          expect {
            Dummy.new.render_data
          }.to raise_exception(NotImplementedError)
        end
      end
    end
  end
end
