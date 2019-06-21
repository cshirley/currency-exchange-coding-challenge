# FreeAgent Coding Challenge

Thank you for your interest in the FreeAgent Coding Challenge.  This template is a barebones guide to get you started.  Please add any gems, folders, files, etc. you see fit in order to produce a solution you're proud of.

## Coding Challenge Instructions

Please see the INSTRUCTIONS.md file for more information.

## Your Solution Setup and Run Instructions

Solution is implemented as a library, with source exchange data accessed relative to the execution path.

To use:

```
bundle install
```

### Within your source file:

```
require 'lib/currency_exchange'

CurrencyExchange.rate(Date.new(2018, 11, 22), "USD", "GBP")
```
### from IRB:

1. Start a console session:

```
bundle exec irb -Ilib
```

2. Load the template library:

```
require 'currency_exchange'
```

3. Calculate an exchange rate:

```
CurrencyExchange.rate(Date.new(2018, 11, 22), "USD", "GBP")
```

### Run Tests
```
bundle exec ruby test/run_tests.rb
```

## Design Decisions

Key design driver was the future need to support multiple strategies for
retrieving currency exchange rate data.  Therefore the main CurrencyExchange facade should allow for dispatch requests through an abstraction that would
eventually support multiple data sources/providers.  This facade could be extended using a factory to select the appropriate strategy based on:

 - Business Decisions
 - Service Availability
 - Service cost per request
 - Through configuration option (i.e. IOC)

In an attempt *not* to over-design the solution we have two levels of abstraction:

 - Rate Strategy: is implemented using a command pattern which forms our strategy for determining the exchange rate based on;

 - Service Object: provides the abstraction for retrieving the raw data providing a contract for find rates by date.

 - Data structures are relatively simple that encapsulating into deeper objects seems unnecessary at this point

Access to the rates is provided by the CurrencyExchange facade.

### Configuration

Explicit decisions not to include a configuration repository at this stage,
but one envisages this would be a logical extension of the library.
