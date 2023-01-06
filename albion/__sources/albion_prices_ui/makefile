buildapp:
	make codegen
	flutter build web --base-href /albion/
copy-outputs:
	cp -R build/web/* ../../
publish:
	make codegen
	flutter build web --release --base-href /albion/
	make copy-outputs
run:
	make codegen
	flutter run -t lib/main_dev.dart
codegen:
	flutter pub run build_runner build --delete-conflicting-outputs