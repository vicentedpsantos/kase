#!/usr/bin/env elixir

defmodule Release do
  # -------------------------------------------
  # Common variables
  # -------------------------------------------

  @version_file "mix.exs"
  @changelog_file "CHANGELOG.md"
  @readme_file "README.md"

  def run do
    version = get_current_version()
    {major, minor, patch} = parse_version(version)

    IO.puts("The current version is: #{version}")
    IO.write("Do you want to release a [major|minor|patch]: ")
    type = String.trim(IO.gets(""))

    {new_major, new_minor, new_patch} =
      case type do
        "major" ->
          {major + 1, 0, 0}

        "minor" ->
          {major, minor + 1, 0}

        "patch" ->
          {major, minor, patch + 1}

        _ ->
          IO.puts("\nRelease canceled!")
          exit(:normal)
      end

    new_version = "#{new_major}.#{new_minor}.#{new_patch}"
    IO.puts("The new version is: #{new_version}")

    IO.puts("\tUpdating #{@version_file} version")
    update_version_file(version, new_version)

    IO.puts("\tUpdating #{@readme_file} version")
    update_readme_file({major, minor, patch}, {new_major, new_minor, new_patch})

    IO.puts("\tUpdating #{@changelog_file} version")
    update_changelog_file(new_version)

    IO.puts("\tRecording changes to the repository")
    create_git_commit_and_tag(new_version)

    IO.puts("\nIf everything's ok, push the changes to upstream!")
  end

  defp get_current_version do
    {:ok, content} = File.read(@version_file)
    [_, version] = Regex.run(~r/version: "(\d+\.\d+\.\d+)"/, content)
    version
  end

  defp parse_version(version) do
    [major, minor, patch] = String.split(version, ".") |> Enum.map(&String.to_integer/1)
    {major, minor, patch}
  end

  defp update_version_file(old_version, new_version) do
    {:ok, content} = File.read(@version_file)

    new_content =
      String.replace(content, ~s(version: "#{old_version}"), ~s(version: "#{new_version}"))

    File.write!(@version_file, new_content)
  end

  defp update_readme_file({old_major, old_minor, old_patch}, {new_major, new_minor, new_patch}) do
    {:ok, content} = File.read(@readme_file)

    new_content =
      String.replace(
        content,
        ~s(#{old_major}.#{old_minor}.#{old_patch}),
        ~s(#{new_major}.#{new_minor}.#{new_patch})
      )

    File.write!(@readme_file, new_content)
  end

  defp update_changelog_file(new_version) do
    {:ok, content} = File.read(@changelog_file)

    new_content =
      content
      |> String.replace(
        "## **Unreleased**",
        "## **Unreleased**\n\n## **#{new_version}** - #{Date.utc_today()}"
      )

    File.write!(@changelog_file, new_content)
  end

  defp create_git_commit_and_tag(new_version) do
    System.cmd("git", ["add", @version_file, @readme_file, @changelog_file])
    System.cmd("git", ["commit", "-m", "Bump to #{new_version}"])
    System.cmd("git", ["tag", "-a", new_version, "-m", ""])
  end
end

Release.run()
