# SLI/SLO flutter sample for measuring "user experience SLI/SLO"

> [!WARNING]
> This repository is still work in progress.

## What's this?

This is a sample project to measure SLI/SLO in flutter apps.
More details at [flutterninjas.dev](https://flutterninjas.dev/)

- [SpeakerDeck(en)](https://speakerdeck.com/ostk0069/slo) 
- [SpeakerDeck(日本語)](https://speakerdeck.com/ostk0069/slowoyong-ite-flutterapuride-yuzati-yan-nopin-zhi-wojian-shi-suru)

## TODOs

- [x] provide success trasaction measurement
- [x] provide cancel trasaction measurement
- [x] provide failure trasaction measurement
- [ ] provide inturruption trasaction measurement (measurement is provided, but example is not made)
- [ ] ~~alert function for error budget alert~~ (This would not be provided in flutter/dart. It is made by TypeScript.)
- [ ] ~~alert function for burn rate alert~~ (This would not be provided in flutter/dart. It is made by TypeScript.)

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
