module ApplicationHelper
  def uglify(lyrics)
    ugly_lyrics = lyrics.split("\r\n")
    new_text = ugly_lyrics.map { |line| "&#9835; #{h(line)}" }
    new_text.join("\r\n").html_safe
  end
end
