#
# ruby implementation of
# https://github.com/domnikl/DesignPatternsPHP/blob/master/Creational/Builder/BuilderInterface.php
#

module DesignPatterns
  module Creational
    module Builder
      module Part
        class Vehicle
          def set_part(name, value)
            parts[name] = value
          end

          protected

          def parts
            @parts ||= {}
          end
        end

        class Bike < Vehicle; end
        class Car < Vehicle; end
        class Door; end
        class Engine; end
        class Wheel; end
      end

      module BuilderInterface
        def create_vehicle
          raise NotImplementedError
        end

        def add_wheels
          raise NotImplementedError
        end

        def add_engine
          raise NotImplementedError
        end

        def add_doors
          raise NotImplementedError
        end

        def get_vehicle
          raise NotImplementedError
        end
      end

      class CarBuilder
        include BuilderInterface

        def add_doors
          car.set_part('door-right', Part::Door.new)
          car.set_part('door-left', Part::Door.new)
        end

        def add_engine
          car.set_part('engine', Part::Engine.new)
        end

        def add_wheels
          car.set_part('wheel-right-front', Part::Wheel.new)
          car.set_part('wheel-left-front', Part::Wheel.new)
          car.set_part('wheel-right-rear', Part::Wheel.new)
          car.set_part('wheel-left-rear', Part::Wheel.new)
        end

        def create_vehicle
          @car = Part::Car.new
        end

        def get_vehicle
          car
        end

        protected
        attr_reader :car
      end

      class BikeBuilder
        include BuilderInterface

        def add_doors; end
        def add_engine; end

        def add_wheels
          bike.set_part('wheel-front', Part::Wheel.new)
          bike.set_part('wheel-rear', Part::Wheel.new)
        end

        def create_vehicle
          @bike = Part::Bike.new
        end

        def get_vehicle
          bike
        end

        protected
        attr_reader :bike
      end

      class Director
        def build(builder)
          builder.create_vehicle
          builder.add_doors
          builder.add_engine
          builder.add_wheels
          builder.get_vehicle
        end
      end

      if $0 == __FILE__
        require 'rspec/autorun'

        RSpec.describe Director do
          subject(:director) { Director.new }

          it 'build returns a vehicle instance' do
            car_builder = CarBuilder.new
            expect(director.build(car_builder)).to be_a(Part::Vehicle)
          end
        end
      end
    end
  end
end
