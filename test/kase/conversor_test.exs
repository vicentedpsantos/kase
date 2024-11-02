defmodule Kase.ConversorTest do
  @moduledoc false

  use ExUnit.Case
  # doctest Kase

  alias Kase.Conversor

  @camel_case "camelCaseExample"
  @cobol_case "COBOL-CASE-EXAMPLE"
  @dot_case "dot.case.example"
  @flat_case "flatcaseexample"
  @humanized_case "Humanized Case Example"
  @kebab_case "kebab-case-example"
  @pascal_case "PascalCaseExample"
  @snake_case "snake_case_example"
  @train_case "Train-Case-Example"
  @upper_case_snake_case "UPPER_CASE_SNAKE_CASE_EXAMPLE"

  describe "Conversor.convert/2" do
    test "converts various cases to flatcase" do
      assert Conversor.convert(@camel_case, :flat_case) == "camelcaseexample"
      assert Conversor.convert(@cobol_case, :flat_case) == "cobolcaseexample"
      assert Conversor.convert(@dot_case, :flat_case) == "dotcaseexample"
      assert Conversor.convert(@flat_case, :flat_case) == "flatcaseexample"
      assert Conversor.convert(@humanized_case, :flat_case) == "humanizedcaseexample"
      assert Conversor.convert(@kebab_case, :flat_case) == "kebabcaseexample"
      assert Conversor.convert(@pascal_case, :flat_case) == "pascalcaseexample"
      assert Conversor.convert(@snake_case, :flat_case) == "snakecaseexample"
      assert Conversor.convert(@train_case, :flat_case) == "traincaseexample"
      assert Conversor.convert(@upper_case_snake_case, :flat_case) == "uppercasesnakecaseexample"
    end

    test "converts various cases to camelCase" do
      assert Conversor.convert(@camel_case, :camel_case) == "camelCaseExample"
      assert Conversor.convert(@cobol_case, :camel_case) == "cobolCaseExample"
      assert Conversor.convert(@dot_case, :camel_case) == "dotCaseExample"
      assert Conversor.convert(@flat_case, :camel_case) == "flatcaseexample"
      assert Conversor.convert(@humanized_case, :camel_case) == "humanizedCaseExample"
      assert Conversor.convert(@kebab_case, :camel_case) == "kebabCaseExample"
      assert Conversor.convert(@pascal_case, :camel_case) == "pascalCaseExample"
      assert Conversor.convert(@snake_case, :camel_case) == "snakeCaseExample"
      assert Conversor.convert(@train_case, :camel_case) == "trainCaseExample"
      assert Conversor.convert(@upper_case_snake_case, :camel_case) == "upperCaseSnakeCaseExample"
    end

    test "converts various cases to snake_case" do
      assert Conversor.convert(@camel_case, :snake_case) == "camel_case_example"
      assert Conversor.convert(@cobol_case, :snake_case) == "cobol_case_example"
      assert Conversor.convert(@dot_case, :snake_case) == "dot_case_example"
      assert Conversor.convert(@flat_case, :snake_case) == "flatcaseexample"
      assert Conversor.convert(@humanized_case, :snake_case) == "humanized_case_example"
      assert Conversor.convert(@kebab_case, :snake_case) == "kebab_case_example"
      assert Conversor.convert(@pascal_case, :snake_case) == "pascal_case_example"
      assert Conversor.convert(@snake_case, :snake_case) == "snake_case_example"
      assert Conversor.convert(@train_case, :snake_case) == "train_case_example"

      assert Conversor.convert(@upper_case_snake_case, :snake_case) ==
               "upper_case_snake_case_example"
    end

    test "converts various cases to kebab-case" do
      assert Conversor.convert(@camel_case, :kebab_case) == "camel-case-example"
      assert Conversor.convert(@cobol_case, :kebab_case) == "cobol-case-example"
      assert Conversor.convert(@dot_case, :kebab_case) == "dot-case-example"
      assert Conversor.convert(@flat_case, :kebab_case) == "flatcaseexample"
      assert Conversor.convert(@humanized_case, :kebab_case) == "humanized-case-example"
      assert Conversor.convert(@kebab_case, :kebab_case) == "kebab-case-example"
      assert Conversor.convert(@pascal_case, :kebab_case) == "pascal-case-example"
      assert Conversor.convert(@snake_case, :kebab_case) == "snake-case-example"
      assert Conversor.convert(@train_case, :kebab_case) == "train-case-example"

      assert Conversor.convert(@upper_case_snake_case, :kebab_case) ==
               "upper-case-snake-case-example"
    end

    test "converts various cases to PascalCase" do
      assert Conversor.convert(@camel_case, :pascal_case) == "CamelCaseExample"
      assert Conversor.convert(@cobol_case, :pascal_case) == "CobolCaseExample"
      assert Conversor.convert(@dot_case, :pascal_case) == "DotCaseExample"
      assert Conversor.convert(@flat_case, :pascal_case) == "Flatcaseexample"
      assert Conversor.convert(@humanized_case, :pascal_case) == "HumanizedCaseExample"
      assert Conversor.convert(@kebab_case, :pascal_case) == "KebabCaseExample"
      assert Conversor.convert(@pascal_case, :pascal_case) == "PascalCaseExample"
      assert Conversor.convert(@snake_case, :pascal_case) == "SnakeCaseExample"
      assert Conversor.convert(@train_case, :pascal_case) == "TrainCaseExample"

      assert Conversor.convert(@upper_case_snake_case, :pascal_case) ==
               "UpperCaseSnakeCaseExample"
    end

    test "converts various cases to UPPER_CASE_SNAKE_CASE" do
      assert Conversor.convert(@camel_case, :upper_case_snake_case) == "CAMEL_CASE_EXAMPLE"
      assert Conversor.convert(@cobol_case, :upper_case_snake_case) == "COBOL_CASE_EXAMPLE"
      assert Conversor.convert(@dot_case, :upper_case_snake_case) == "DOT_CASE_EXAMPLE"
      assert Conversor.convert(@flat_case, :upper_case_snake_case) == "FLATCASEEXAMPLE"

      assert Conversor.convert(@humanized_case, :upper_case_snake_case) ==
               "HUMANIZED_CASE_EXAMPLE"

      assert Conversor.convert(@kebab_case, :upper_case_snake_case) == "KEBAB_CASE_EXAMPLE"
      assert Conversor.convert(@pascal_case, :upper_case_snake_case) == "PASCAL_CASE_EXAMPLE"
      assert Conversor.convert(@snake_case, :upper_case_snake_case) == "SNAKE_CASE_EXAMPLE"
      assert Conversor.convert(@train_case, :upper_case_snake_case) == "TRAIN_CASE_EXAMPLE"

      assert Conversor.convert(@upper_case_snake_case, :upper_case_snake_case) ==
               "UPPER_CASE_SNAKE_CASE_EXAMPLE"
    end

    test "converts various cases to Train-Case" do
      assert Conversor.convert(@camel_case, :train_case) == "Camel-Case-Example"
      assert Conversor.convert(@cobol_case, :train_case) == "Cobol-Case-Example"
      assert Conversor.convert(@dot_case, :train_case) == "Dot-Case-Example"
      assert Conversor.convert(@flat_case, :train_case) == "Flatcaseexample"
      assert Conversor.convert(@humanized_case, :train_case) == "Humanized-Case-Example"
      assert Conversor.convert(@kebab_case, :train_case) == "Kebab-Case-Example"
      assert Conversor.convert(@pascal_case, :train_case) == "Pascal-Case-Example"
      assert Conversor.convert(@snake_case, :train_case) == "Snake-Case-Example"
      assert Conversor.convert(@train_case, :train_case) == "Train-Case-Example"

      assert Conversor.convert(@upper_case_snake_case, :train_case) ==
               "Upper-Case-Snake-Case-Example"
    end

    test "converts various cases to COBOL-CASE" do
      assert Conversor.convert(@camel_case, :cobol_case) == "CAMEL-CASE-EXAMPLE"
      assert Conversor.convert(@cobol_case, :cobol_case) == "COBOL-CASE-EXAMPLE"
      assert Conversor.convert(@dot_case, :cobol_case) == "DOT-CASE-EXAMPLE"
      assert Conversor.convert(@flat_case, :cobol_case) == "FLATCASEEXAMPLE"
      assert Conversor.convert(@humanized_case, :cobol_case) == "HUMANIZED-CASE-EXAMPLE"
      assert Conversor.convert(@kebab_case, :cobol_case) == "KEBAB-CASE-EXAMPLE"
      assert Conversor.convert(@pascal_case, :cobol_case) == "PASCAL-CASE-EXAMPLE"
      assert Conversor.convert(@snake_case, :cobol_case) == "SNAKE-CASE-EXAMPLE"
      assert Conversor.convert(@train_case, :cobol_case) == "TRAIN-CASE-EXAMPLE"

      assert Conversor.convert(@upper_case_snake_case, :cobol_case) ==
               "UPPER-CASE-SNAKE-CASE-EXAMPLE"
    end

    test "converts various cases to dot.case" do
      assert Conversor.convert(@camel_case, :dot_case) == "camel.case.example"
      assert Conversor.convert(@cobol_case, :dot_case) == "cobol.case.example"
      assert Conversor.convert(@dot_case, :dot_case) == "dot.case.example"
      assert Conversor.convert(@flat_case, :dot_case) == "flatcaseexample"
      assert Conversor.convert(@humanized_case, :dot_case) == "humanized.case.example"
      assert Conversor.convert(@kebab_case, :dot_case) == "kebab.case.example"
      assert Conversor.convert(@pascal_case, :dot_case) == "pascal.case.example"
      assert Conversor.convert(@snake_case, :dot_case) == "snake.case.example"
      assert Conversor.convert(@train_case, :dot_case) == "train.case.example"

      assert Conversor.convert(@upper_case_snake_case, :dot_case) ==
               "upper.case.snake.case.example"
    end

    test "converts various cases to Humanized Case" do
      assert Conversor.convert(@camel_case, :humanized_case) == "Camel Case Example"
      assert Conversor.convert(@cobol_case, :humanized_case) == "Cobol Case Example"
      assert Conversor.convert(@dot_case, :humanized_case) == "Dot Case Example"
      assert Conversor.convert(@flat_case, :humanized_case) == "Flatcaseexample"
      assert Conversor.convert(@humanized_case, :humanized_case) == "Humanized Case Example"
      assert Conversor.convert(@kebab_case, :humanized_case) == "Kebab Case Example"
      assert Conversor.convert(@pascal_case, :humanized_case) == "Pascal Case Example"
      assert Conversor.convert(@snake_case, :humanized_case) == "Snake Case Example"
      assert Conversor.convert(@train_case, :humanized_case) == "Train Case Example"

      assert Conversor.convert(@upper_case_snake_case, :humanized_case) ==
               "Upper Case Snake Case Example"
    end
  end
end
