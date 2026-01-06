// nextRelease.version is going to be templated by semantic release
const updateImageTagRegEx = "s/^(version: \"?v)[^\"]+(\"?)$/\\1${nextRelease.version}\\2/g"
export default {
  branches: [
    { name: process.env.CI_DEFAULT_BRANCH },
  ],
  plugins: [
    ["@semantic-release/changelog", {
      changelogFile: "CHANGELOG.md",
      changelogTitle: "# Changelog"
    }],
    ["@semantic-release/exec", {
      prepareCmd: `sed -ri '${updateImageTagRegEx}' forgejo/config.yaml`
    }],
    ["@semantic-release/commit-analyzer", { preset: "conventionalcommits" }],
    ["@semantic-release/release-notes-generator", { preset: "conventionalcommits" }],
    ["@semantic-release/git", {
      assets: ["CHANGELOG.md", "forgejo/config.yaml", ".gitlab-ci.yml"],
      message: "chore(release): ${nextRelease.version}\n\n${nextRelease.notes}"
    }],
    "@semantic-release/gitlab",
  ],
};
