# SLI/SLO flutter sample

> [!WARNING]
> This repository is still work in progress. Not all features are provided.

## What's this?

This is a sample project to measure SLI/SLO in flutter apps.
This was talked in [flutterninjas.dev](https://flutterninjas.dev/)

- [SpeakerDeck(en)]() 
- [SpeakerDeck(日本語)]()

## TODOs

- [x] provide success trasaction measurement
- [x] provide cancel trasaction measurement
- [x] provide failure trasaction measurement
- [ ] provide inturruption trasaction measurement (measurement is provided, but example is not made)
- [ ] ~~alert function for error budget alert~~ (This would not be provided in flutter/dart. I made with TypeScript in my project)
- [ ] ~~alert function for burn rate alert~~ (This would not be provided in flutter/dart. I made with TypeScript in my project)

## Setup

1. install flutter

```
$ asdf local flutter << your version >>
```

2. pub get in each `example` and `sli_slo` packages

```
$ cd sli_slo
$ flutter pub get
```

```
$ cd example
$ flutter pub get
```

3. build flutter apps of `example` packages

```
$ flutter run
```
