# Builder Pattern

> The builder pattern is an object creation software design pattern. Unlike the
> abstract factory pattern and the factory method pattern whose intention is to
> enable polymorphism, the intention of the builder pattern is to find a
> solution to the telescoping constructor anti-pattern. The
> telescoping constructor anti-pattern occurs when the increase of object
> constructor parameter combination leads to an exponential list of
> constructors. Instead of using numerous constructors, the builder pattern uses
> another object, a builder, that receives each initialization parameter step by
> step and then returns the resulting constructed object at once.

> The builder pattern has another benefit. It can be used for objects that
> contain flat data (html code, SQL query, X.509 certificate...), that is to
> say, data that can't be easily edited. This type of data cannot be edited step
> by step and must be edited at once. The best way to construct such an object
> is to use a builder class.

> Builder often builds a Composite. Often, designs start out using Factory
> Method (less complicated, more customizable, subclasses proliferate) and
> evolve toward Abstract Factory, Prototype, or Builder (more flexible, more
> complex) as the designer discovers where more flexibility is needed. Sometimes
> creational patterns are complementary: Builder can use one of the other
> patterns to implement which components are built. Builders are good candidates
> for a fluent interface.
>
> [Wikipedia](https://en.wikipedia.org/wiki/Builder_pattern)

## Examples:

- [PHP](https://github.com/domnikl/DesignPatternsPHP/tree/master/Creational/Builder)
