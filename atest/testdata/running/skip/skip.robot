*** Settings ***
Library            skiplib.py

*** Variables ***
${TEST_OR_TASK}    test

*** Test Cases ***
Skip Keyword
    [Documentation]    SKIP Skipped with Skip keyword.
    Skip
    Fail    Should not be executed!

Skip with Library Keyword
    [Documentation]    SKIP Show must not got on
    Skip with Message    Show must not got on
    Fail    Should not be executed!

Skip If Keyword with True Condition
    [Documentation]    SKIP 1 == 1
    Skip If    1 == 1
    Fail    Should not be executed!

Skip If Keyword with True Condition And Custom Message
    [Documentation]    SKIP Skipped with abandon.
    Skip If    1 == 1    Skipped with abandon.
    Fail    Should not be executed!

Skip If Keyword with False Condition
    [Documentation]    FAIL Should be executed!
    Skip If    1 == 2
    Fail    Should be executed!

Skip Keyword with Custom Message
    [Documentation]    SKIP Skipped due to reasons
    Skip    Skipped due to reasons
    Fail    Should not be executed!

Skip in Setup
    [Documentation]    SKIP Setup skip
    [Setup]    Skip    Setup skip
    Fail    Should not be executed!

Remaining setup keywords aren't run after skip
    [Documentation]    SKIP Skip between keywords
    [Setup]    Skip with keywords before and after
    Fail    Should not be executed!

Skip in Teardown
    [Documentation]    SKIP Teardown skip
    No operation
    [Teardown]    Skip    Teardown skip

Remaining teardown keywords aren't run after skip
    [Documentation]    SKIP Skip between keywords
    No operation
    [Teardown]    Skip with keywords before and after

Skip in Teardown After Failure In Body
    [Documentation]    SKIP
    ...    Skipped in teardown:
    ...    Teardown skip
    ...
    ...    Earlier message:
    ...    Failure in body!
    Fail    Failure in body!
    [Teardown]    Skip    Teardown skip

Teardown is executed after skip
    [Documentation]    SKIP Skip in body
    Skip    Skip in body
    [Teardown]    Log    Teardown is executed!

Fail in Teardown After Skip In Body
    [Documentation]    SKIP
    ...    Skip in body
    ...
    ...    Also teardown failed:
    ...    Teardown failed!
    Skip    Skip in body
    [Teardown]    Fail    Teardown failed!

Skip in Teardown After Skip In Body
    [Documentation]    SKIP
    ...    Skipped in teardown:
    ...    Teardown skip
    ...
    ...    Earlier message:
    ...    Skip in body
    Skip    Skip in body
    [Teardown]    Skip    Teardown skip

Skip with Continuable Failure
    [Documentation]    SKIP
    ...    Skipping should stop execution but test should still fail
    ...
    ...    Also failure occurred:
    ...    We can continue!
    Run Keyword And Continue On Failure
    ...    Fail    We can continue!
    Skip    Skipping should stop execution but test should still fail
    Fail    Should not be executed!

Skip with Multiple Continuable Failures
    [Documentation]    SKIP
    ...    Skip after two failures
    ...
    ...    Also failures occurred:
    ...
    ...    1) We can continue!
    ...
    ...    2) We can continue again!
    Run Keyword And Continue On Failure
    ...    Fail    We can continue!
    Run Keyword And Continue On Failure
    ...    Fail    We can continue again!
    Skip    Skip after two failures
    Fail    Should not be executed!

Skip in Teardown After Continuable Failures
    [Documentation]    SKIP
    ...    Skipped in teardown:
    ...    Teardown skip
    ...
    ...    Earlier message:
    ...    Several failures occurred:
    ...
    ...    1) We can continue!
    ...
    ...    2) We can continue again!
    Run Keyword And Continue On Failure
    ...    Fail    We can continue!
    Run Keyword And Continue On Failure
    ...    Fail    We can continue again!
    [Teardown]    Skip    Teardown skip

Skip with Pass Execution in Teardown
    [Documentation]    SKIP Skip in body
    Skip    Skip in body
    [Teardown]    Run Keywords
    ...    Pass Execution    Thou shall pass
    ...    AND
    ...    Fail    Should not be executed!

Skip in Teardown with Pass Execution in Body
    [Documentation]    SKIP Then we skip
    Pass Execution    First we pass
    [Teardown]    Skip  Then we skip

Skipped with --skip
    [Documentation]    SKIP ${TEST_OR_TASK.title()} skipped with '--skip' command line option.
    [Tags]    skip-this
    Fail

Skipped with --SkipOnFailure
    [Documentation]    SKIP
    ...    Failing  ${TEST_OR_TASK} was marked skipped because skip-on-failure mode was active.
    ...
    ...    Original failure:
    ...    Ooops, we fail!
    [Tags]    skip-on-failure
    Fail    Ooops, we fail!

--SkipOnFailure when skipping tag is added dynamically
    [Documentation]    SKIP
    ...    Failing ${TEST_OR_TASK} was marked skipped because skip-on-failure mode was active.
    ...
    ...    Original failure:
    ...    This test should be skipped
    Set Tags    skip-on-failure
    Fail    This test should be skipped

--SkipOnFailure when skipping tag is removed dynamically
    [Documentation]    FAIL This test should fail
    [Tags]    skip-on-failure
    Remove Tags    skip-on-failure
    Fail    This test should fail

--NonCritical Is an Alias for --SkipOnFailure
    [Documentation]    SKIP
    ...    Failing ${TEST_OR_TASK} was marked skipped because skip-on-failure mode was active.
    ...
    ...    Original failure:
    ...    AssertionError
    [Tags]    non-crit
    Fail

--Critical can be used to override --SkipOnFailure
    [Documentation]    FAIL AssertionError
    [Tags]    dynamic-skip    crit
    Fail

Failing Test
    [Documentation]    FAIL AssertionError
    Fail

Passing Test
    No Operation

*** Keywords ***
Skip with keywords before and after
    No Operation
    Skip    Skip between keywords
    Fail    Should not be executed!