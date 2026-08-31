# Smart Tracking — Flutter client

Mobile client for a fleet-tracking app: it shows where a vehicle is, replays
where it has been, and lets the owner draw geofences and get notified when the
vehicle crosses one. Talks to the
[Rails API](https://github.com/duvanherfi/smart-tracking-back). Final
integrative project of the MSc in Intelligent Applications, Universidad del
Valle; the manuals live in
[smart-tracking-docs](https://github.com/duvanherfi/smart-tracking-docs).

## What it does

- **Live position and trip replay** on a `flutter_map` tile layer, centred on
  the vehicle.
- **Geofences drawn on the map.** A circle from a centre and a radius, or a free
  polygon whose vertices are dragged into place with `flutter_map_dragmarker`.
  The API turns either into GeoJSON and labels it with a street address.
- **Recommended geofences** proposed by the API from where the vehicle actually
  spends its time, so the owner does not have to draw the obvious ones.
- **Push notifications** through Firebase Cloud Messaging when a fence is
  crossed, with a history screen per notification type.
- Login, password recovery, profile and sharing a vehicle with another user.

## Layout

One folder per feature (`home`, `geofences`, `notifications`, `login`, `user`,
`share`, `user_notifications`), each split into `screen`, `view_model` and
`repository`; `lib/api` holds the datasources and the models they deserialize
into. State is `provider`.

## Running it

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

The repo pins its Flutter version with [fvm](https://fvm.app), so prefix the
commands with `fvm` if you use it.

### It will not connect to anything as it stands

`lib/utils/enviroments.dart` still points at `https://api.smartracking.xyz`,
which **no longer resolves** — the domain is gone, checked on 2026-08-31. To
get past the login screen you have to run the
[backend](https://github.com/duvanherfi/smart-tracking-back) yourself and point
the app at it, either by editing that file or by writing the URL into the
app's own preferences (`SharedPreferencesV2.setApiBaseUrl`, which the file
already reads and which overrides the compiled default at runtime). There is a
commented-out LAN address in there showing the shape it expects, path included:
`http://host:3001/api/v1/`.

And the backend, in turn, needs an account with a commercial GPS provider that
is not mine to hand out — its README says which variables and why.

Push notifications need **your own** Firebase project: the committed
`google-services.json` and `firebase_options.dart` name a project you have no
access to. Replace all three files with the ones `flutterfire configure`
generates for yours, or leave them and skip messaging — nothing else in the app
depends on it.

## A note on what is committed

`android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist` and
`lib/firebase_options.dart` are checked in, which is how Firebase expects a
client app to ship: those identifiers are meant to be public, and what actually
protects the project are its Firestore and Storage rules, not the file.

The support phone number and the map's fallback coordinates in this repository
are placeholders, not the ones the released app used.
