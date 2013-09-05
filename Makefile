PROJECT = ClassHookWebView.xcodeproj
TEST_TARGET = ClassHookWebViewTests
clean:
	xcodebuild \
		-project ClassHookWebView.xcodeproj \
		clean

test:
	xcodebuild \
		-project $(PROJECT) \
		-target $(TEST_TARGET) \
		-sdk iphonesimulator \
		-configuration Debug \
		ONLY_ACTIVE_ARCH=NO \
		TEST_AFTER_BUILD=YES \
		TEST_HOST= 
