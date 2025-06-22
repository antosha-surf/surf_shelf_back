# Runs pub get
pg:
	fvm flutter pub get

# Runs flutter clean
cleanup:
	fvm flutter clean

# Codegen
codegen:
	fvm dart run build_runner build --delete-conflicting-outputs


regen:
	make cleanup
	make pg
	make codegen

# Sorts arb files alphabetically
sort_arb:
	fvm dart run arb_utils:sort lib/l10n/intl_en.arb
	fvm dart run arb_utils:sort lib/l10n/intl_ar.arb

# Spider -> https://pub.dev/packages/spider
spider:
	spider build

# Linting
lint:
	fvm flutter analyze


