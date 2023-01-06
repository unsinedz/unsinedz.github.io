buildapp:
	flutter build web --base-href /albion/
copy-outputs:
	cp -R build/web/* ../../
publish:
	make buildapp
	make copy-outputs