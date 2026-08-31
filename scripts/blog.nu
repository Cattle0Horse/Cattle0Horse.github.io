def main [] {
  let now = date now
  let identifier = ($now | format date "%Y-%m-%d-%H%M%S")
  let content_path = (["posts" $identifier] | path join)
  let target_path = (["content" $content_path "index.md"] | path join)

  if ($target_path | path exists) {
    error make { msg: $"Blog post already exists: ($target_path)" }
  }

  ^hugo new content $content_path

  if $env.LAST_EXIT_CODE != 0 {
    error make { msg: $"Failed to create Blog post: ($target_path)" }
  }

  ^code $target_path
}

