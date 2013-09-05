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
		TEST_AFTER_BUILD=YES \
		TEST_HOST= \
		GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
		GCC_GENERATE_TEST_COVERAGE_FILES=YES
