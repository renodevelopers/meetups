#
# ruby implementation of
#   https://github.com/domnikl/DesignPatternsPHP/blob/master/Creational/Singleton/Singleton.php
#

module DesignPatterns
  module Creational
    module Singleton

      class SingletonPatternViolationError < ArgumentError; end

      class Singleton
        def self.instance
          return @_instance if @_instance
          @_instance = allocate
          @_instance.send(:initialize)
          @_instance
        end

        def self.new
          raise SingletonPatternViolationError
        end

        def clone
          raise SingletonPatternViolationError
        end

        def dup
          raise SingletonPatternViolationError
        end
      end

      if $0 == __FILE__
        require 'rspec/autorun'

        RSpec.describe Singleton do
          it 'returns the same instance' do
            subject = Singleton.instance
            expect(subject).to be_a(Singleton)
            expect(subject).to equal(Singleton.instance)
          end

          it 'does not have a constructor' do
            expect {
              Singleton.new
            }.to raise_exception(SingletonPatternViolationError)
          end

          it 'singletons can not be copied' do
            expect {
              Singleton.instance.dup
            }.to raise_exception(SingletonPatternViolationError)
            expect {
              Singleton.instance.clone
            }.to raise_exception(SingletonPatternViolationError)
          end

          it 'subclasses work the same way' do
            class Cat < Singleton
            end
            expect(Cat.instance).to equal(Cat.instance)
          end
        end
      end
    end
  end
end
