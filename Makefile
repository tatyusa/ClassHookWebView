PROJECT = ClassHookWebView.xcodeproj
TEST_SCHEME = ClassHookWebViewTests

test:
	xctool/xctool.sh -project $(PROJECT) -scheme $(TEST_SCHEME) -sdk iphonesimulator -configuration Debug clean build test \
	  -test-sdk iphonesimulator6.1 \
	  ONLY_ACTIVE_ARCH=NO
