# code_scann

Barcode scanning application use to scann the qr / 2D barcode of inventory and can share it with respective person as well.

Key Features : - Scann 2d Bar code - Local db to store the code locally while offline - Can export the file to csv locally. - Can make call to server with posting all local data. - Can check is internet available or not. - Notify the user with snackbar regarding operation status.

## SCREENS

![](app_gif.mp4)

![Listing page](./example/code_listing_page.png?raw=true 'LISTING PAGE')
![Scanner page](./example/scanner.png?raw=true 'LISTING PAGE')
![Settings page](./example/settings_page.png?raw=true 'LISTING PAGE')

## To run project locally

`flutter run`

## To create build runner for ios

`flutter build ios --release`

## Once build runner.app file created make the archive of it using xCode and clicking on distribute app select the signin profile and proper settings.

## To create android build

`flutter build apk --release`

## Plugins used:

- barcode_scan: 0.0.8
- csv: 4.0.2
- dio: 2.1.0
- sqflite: 0.13.0+1

## License

Copyright (c) 2019 Sahil Kashetwar
