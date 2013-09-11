PROJECT = ClassHookWebView.xcodeproj
TEST_SCHEME = ClassHookWebViewTests

clean:
	xcodebuild \
		-project ClassHookWebView.xcodeproj \
		clean

test:
	xctool/xctool.sh -project $(PROJECT) -scheme $(TEST_SCHEME) -sdk iphonesimulator test
