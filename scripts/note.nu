def main [] {
  let now = date now
  let month = ($now | format date "%Y-%m")
  let notes_dir = (["content" "notes" $month] | path join)

  let numbers = if ($notes_dir | path exists) {
    ls $notes_dir
      | where type == file
      | get name
      | path parse
      | get stem
      | where { |stem| $stem =~ '^\d{3}$' }
      | each { |stem| $stem | into int }
  } else {
    []
  }

  let highest = if ($numbers | is-empty) { 0 } else { $numbers | math max }
  let next = $highest + 1

  if $next > 999 {
    error make { msg: $"The month ($month) already contains 999 notes." }
  }

  let filename = (($next | fill --alignment right --character '0' --width 3) + ".md")
  let content_path = (["notes" $month $filename] | path join)
  let target_path = (["content" $content_path] | path join)

  if ($target_path | path exists) {
    error make { msg: $"Note already exists: ($target_path)" }
  }

  ^hugo new content $content_path

  if $env.LAST_EXIT_CODE != 0 {
    error make { msg: $"Failed to create Note: ($target_path)" }
  }

  ^code $target_path
}
