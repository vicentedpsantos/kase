defmodule KaseTest do
  @moduledoc false

  use ExUnit.Case
  # doctest Kase

  @camel_case "camelCaseExample"
  @snake_case "snake_case_example"
  @kebab_case "kebab-case-example"
  @pascal_case "PascalCaseExample"
  @upper_case_snake_case "UPPER_CASE_SNAKE_CASE_EXAMPLE"
  @train_case "Train-Case-Example"
  @cobol_case "COBOL-CASE-EXAMPLE"
  @dot_case "dot.case.example"
  @humanized_case "Humanized Case Example"

  describe "Kase.convert/2" do
    test "converts various cases to camelCase" do
      assert Kase.convert(@camel_case, :camel_case) == "camelCaseExample"
      assert Kase.convert(@snake_case, :camel_case) == "snakeCaseExample"
      assert Kase.convert(@kebab_case, :camel_case) == "kebabCaseExample"
      assert Kase.convert(@pascal_case, :camel_case) == "pascalCaseExample"
      assert Kase.convert(@upper_case_snake_case, :camel_case) == "upperCaseSnakeCaseExample"
      assert Kase.convert(@train_case, :camel_case) == "trainCaseExample"
      assert Kase.convert(@cobol_case, :camel_case) == "cobolCaseExample"
      assert Kase.convert(@dot_case, :camel_case) == "dotCaseExample"
      assert Kase.convert(@humanized_case, :camel_case) == "humanizedCaseExample"
    end

    test "converts various cases to snake_case" do
      assert Kase.convert(@camel_case, :snake_case) == "camel_case_example"
      assert Kase.convert(@snake_case, :snake_case) == "snake_case_example"
      assert Kase.convert(@kebab_case, :snake_case) == "kebab_case_example"
      assert Kase.convert(@pascal_case, :snake_case) == "pascal_case_example"
      assert Kase.convert(@upper_case_snake_case, :snake_case) == "upper_case_snake_case_example"
      assert Kase.convert(@train_case, :snake_case) == "train_case_example"
      assert Kase.convert(@cobol_case, :snake_case) == "cobol_case_example"
      assert Kase.convert(@dot_case, :snake_case) == "dot_case_example"
      assert Kase.convert(@humanized_case, :snake_case) == "humanized_case_example"
    end

    test "converts various cases to kebab-case" do
      assert Kase.convert(@camel_case, :kebab_case) == "camel-case-example"
      assert Kase.convert(@snake_case, :kebab_case) == "snake-case-example"
      assert Kase.convert(@kebab_case, :kebab_case) == "kebab-case-example"
      assert Kase.convert(@pascal_case, :kebab_case) == "pascal-case-example"
      assert Kase.convert(@upper_case_snake_case, :kebab_case) == "upper-case-snake-case-example"
      assert Kase.convert(@train_case, :kebab_case) == "train-case-example"
      assert Kase.convert(@cobol_case, :kebab_case) == "cobol-case-example"
      assert Kase.convert(@dot_case, :kebab_case) == "dot-case-example"
      assert Kase.convert(@humanized_case, :kebab_case) == "humanized-case-example"
    end

    test "converts various cases to PascalCase" do
      assert Kase.convert(@camel_case, :pascal_case) == "CamelCaseExample"
      assert Kase.convert(@snake_case, :pascal_case) == "SnakeCaseExample"
      assert Kase.convert(@kebab_case, :pascal_case) == "KebabCaseExample"
      assert Kase.convert(@pascal_case, :pascal_case) == "PascalCaseExample"
      assert Kase.convert(@upper_case_snake_case, :pascal_case) == "UpperCaseSnakeCaseExample"
      assert Kase.convert(@train_case, :pascal_case) == "TrainCaseExample"
      assert Kase.convert(@cobol_case, :pascal_case) == "CobolCaseExample"
      assert Kase.convert(@dot_case, :pascal_case) == "DotCaseExample"
      assert Kase.convert(@humanized_case, :pascal_case) == "HumanizedCaseExample"
    end

    test "converts various cases to UPPER_CASE_SNAKE_CASE" do
      assert Kase.convert(@camel_case, :upper_case_snake_case) == "CAMEL_CASE_EXAMPLE"
      assert Kase.convert(@snake_case, :upper_case_snake_case) == "SNAKE_CASE_EXAMPLE"
      assert Kase.convert(@kebab_case, :upper_case_snake_case) == "KEBAB_CASE_EXAMPLE"
      assert Kase.convert(@pascal_case, :upper_case_snake_case) == "PASCAL_CASE_EXAMPLE"

      assert Kase.convert(@upper_case_snake_case, :upper_case_snake_case) ==
               "UPPER_CASE_SNAKE_CASE_EXAMPLE"

      assert Kase.convert(@train_case, :upper_case_snake_case) == "TRAIN_CASE_EXAMPLE"
      assert Kase.convert(@cobol_case, :upper_case_snake_case) == "COBOL_CASE_EXAMPLE"
      assert Kase.convert(@dot_case, :upper_case_snake_case) == "DOT_CASE_EXAMPLE"
      assert Kase.convert(@humanized_case, :upper_case_snake_case) == "HUMANIZED_CASE_EXAMPLE"
    end

    test "converts various cases to Train-Case" do
      assert Kase.convert(@camel_case, :train_case) == "Camel-Case-Example"
      assert Kase.convert(@snake_case, :train_case) == "Snake-Case-Example"
      assert Kase.convert(@kebab_case, :train_case) == "Kebab-Case-Example"
      assert Kase.convert(@pascal_case, :train_case) == "Pascal-Case-Example"
      assert Kase.convert(@upper_case_snake_case, :train_case) == "Upper-Case-Snake-Case-Example"
      assert Kase.convert(@train_case, :train_case) == "Train-Case-Example"
      assert Kase.convert(@cobol_case, :train_case) == "Cobol-Case-Example"
      assert Kase.convert(@dot_case, :train_case) == "Dot-Case-Example"
      assert Kase.convert(@humanized_case, :train_case) == "Humanized-Case-Example"
    end

    test "converts various cases to COBOL-CASE" do
      assert Kase.convert(@camel_case, :cobol_case) == "CAMEL-CASE-EXAMPLE"
      assert Kase.convert(@snake_case, :cobol_case) == "SNAKE-CASE-EXAMPLE"
      assert Kase.convert(@kebab_case, :cobol_case) == "KEBAB-CASE-EXAMPLE"
      assert Kase.convert(@pascal_case, :cobol_case) == "PASCAL-CASE-EXAMPLE"
      assert Kase.convert(@upper_case_snake_case, :cobol_case) == "UPPER-CASE-SNAKE-CASE-EXAMPLE"
      assert Kase.convert(@train_case, :cobol_case) == "TRAIN-CASE-EXAMPLE"
      assert Kase.convert(@cobol_case, :cobol_case) == "COBOL-CASE-EXAMPLE"
      assert Kase.convert(@dot_case, :cobol_case) == "DOT-CASE-EXAMPLE"
      assert Kase.convert(@humanized_case, :cobol_case) == "HUMANIZED-CASE-EXAMPLE"
    end

    test "converts various cases to dot.case" do
      assert Kase.convert(@camel_case, :dot_case) == "camel.case.example"
      assert Kase.convert(@snake_case, :dot_case) == "snake.case.example"
      assert Kase.convert(@kebab_case, :dot_case) == "kebab.case.example"
      assert Kase.convert(@pascal_case, :dot_case) == "pascal.case.example"
      assert Kase.convert(@upper_case_snake_case, :dot_case) == "upper.case.snake.case.example"
      assert Kase.convert(@train_case, :dot_case) == "train.case.example"
      assert Kase.convert(@cobol_case, :dot_case) == "cobol.case.example"
      assert Kase.convert(@dot_case, :dot_case) == "dot.case.example"
      assert Kase.convert(@humanized_case, :dot_case) == "humanized.case.example"
    end

    test "converts various cases to Humanized Case" do
      assert Kase.convert(@camel_case, :humanized_case) == "Camel Case Example"
      assert Kase.convert(@snake_case, :humanized_case) == "Snake Case Example"
      assert Kase.convert(@kebab_case, :humanized_case) == "Kebab Case Example"
      assert Kase.convert(@pascal_case, :humanized_case) == "Pascal Case Example"

      assert Kase.convert(@upper_case_snake_case, :humanized_case) ==
               "Upper Case Snake Case Example"

      assert Kase.convert(@train_case, :humanized_case) == "Train Case Example"
      assert Kase.convert(@cobol_case, :humanized_case) == "Cobol Case Example"
      assert Kase.convert(@dot_case, :humanized_case) == "Dot Case Example"
      assert Kase.convert(@humanized_case, :humanized_case) == "Humanized Case Example"
    end
  end
end
