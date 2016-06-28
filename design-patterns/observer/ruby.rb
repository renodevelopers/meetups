require 'pp'
class Bus
  def initialize
    @callables = Hash.new {|h,k| h[k] = [] }
  end
  def on(name, callable)
    @callables[name] << callable
  end
  def trigger(name)
    @callables[name].each do |callable|
      callable.call(name)
    end
  end
end
class Student
  attr_reader :name
  def initialize(name)
    @name = name
  end
  def say_hi
    puts "#{ name } says hi"
  end
  def say_bye
    puts "#{ name } says peace!"
  end
  def call(name)
    case name
    when "enter"
      say_hi
    when "exam"
      say_bye
    end
  end
end
class Teacher
  def method_missing(name, bus)
    bus.trigger(name.to_s)
  end
end
bus = Bus.new
students = Array.new(3) do |i|
  Student.new("Student #{ i }")
end
students.each do |student|
  bus.on('enter', student)
end
olaf = Student.new('Olaf')
bus.on('enter', olaf)
bus.on('exam', olaf)
elsa = Student.new('Elsa')
bus.on('exam', ->(x) { elsa.say_bye })
bus.on('exam', ->(x) { puts "FIREALARM" })
teacher = Teacher.new
teacher.enter(bus)
teacher.exam(bus)
pp bus
