buildapp:
	make codegen
	flutter build web --base-href /albion/
copy-outputs:
	find ../.. -mindepth 1 ! -regex '^../../__sources.*' -delete
	cp -R build/web/* ../../
publish:
	make codegen
	flutter build web --release --base-href /albion/
	make copy-outputs
run:
	make codegen
	flutter run -t lib/main_dev.dart --web-port 16969
run-prod:
	make codegen
	flutter run --web-port 16969
codegen:
	flutter pub run build_runner build --delete-conflicting-outputs