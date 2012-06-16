Feature: Snippets localized format
  In order to see only undefined steps snippets
  As a tester
  I need to be able to use 'snippets' formatter

  Background:
    Given a file named "features/bootstrap/FeatureContext.php" with:
      """
      <?php

      require_once 'PHPUnit/Autoload.php';
      require_once 'PHPUnit/Framework/Assert/Functions.php';

      use Behat\Behat\Context\BehatContext,
          Behat\Behat\Exception\PendingException;
      use Behat\Gherkin\Node\PyStringNode,
          Behat\Gherkin\Node\TableNode;

      class FeatureContext extends BehatContext
      {
          private $parameters;

          public function __construct(array $parameters) {
              $this->parameters = $parameters;
          }
      }
      """
    And a file named "features/ja_addition.feature" with:
      """
      # language: ja
      フィーチャ: 未定義のエラー
        日本語で書いてあっても
        ちゃんとステップキーワードを識別して
        スニペットを出力したい

        シナリオ: 日本語でのスニペットの出力について
          前提 前提はGivenである
          もし もしがWhenである
          ならば 結果はThenである
      """

  Scenario: Run feature with failing scenarios
    When I run "behat -f snippets"
    Then it should pass with:
      """
      /**
           * @Given /^前提はGivenである$/
           */
          public function given()
          {
              throw new PendingException();
          }

          /**
           * @When /^もしがWhenである$/
           */
          public function when()
          {
              throw new PendingException();
          }

          /**
           * @Then /^結果はThenである$/
           */
          public function huanThen()
          {
              throw new PendingException();
          }
      """


