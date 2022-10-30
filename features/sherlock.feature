Feature: Sherlock
  Scenario: User passes -d option
    When I run `sherlock analyze -d test_log_dir`
    Then the output should contain "Hello World!"

  Scenario: User passes -f option
    When I run `sherlock analyze -f test_log`
    Then the output should contain "Hello World!"
