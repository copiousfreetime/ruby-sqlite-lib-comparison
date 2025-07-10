# Compare ruby sqlite3 libraries and compare their performance

This repository contains a benchmark to compare the performance of different
Ruby SQLite3 libraries. The libraries being compared are:

- [sqlite3](https://github.com/sparklemotion/sqlite3-ruby)
- [extralite](https://github.com/digital-fabric/extralite)
- [amalgalite](https://github.com/copiousfreetime/amalgalite)

## Notes

The [notes](./notes) directory contains notes on how the different libraries
implements aspects of sqlite3.

## Getting Started

```
bundle install
```

## Running the Benchmarks

```
bundle exec rake perf
```
## Credits

The benchmarks here are originally pulled from [extralite/tests/perf_*](https://github.com/digital-fabric/extralite/tree/main/test)
