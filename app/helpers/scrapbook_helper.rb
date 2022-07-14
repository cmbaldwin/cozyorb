module ScrapbookHelper

  def owned_tweet(post, tweet)
    return 'bg-white' unless tweet

    if post.retweeted == false && post.is_quote_status == false && post.truncated == false && post.in_reply_to_screen_name == nil
      'bg-sky-100'
    else
      'bg-white'
    end
  end

  def post_type_icon(post)
    type = post.class.name

    case type
    when 'Like'
      '👍'
    when 'Tweet'
      post.retweeted ? '♻️' : '🐦'
    else
      '📝'
    end
  end

  def help_markdown
    <<~HTML
      <div class='p-1'>
        <b>#{(link_to('Scrapbook', scrapbook_path, class: "text-white"))}</b>
        <p class='small mt-2'>
          This is a collection of tweets, retweets 
          and likes (which I mainly treat as bookmarks). 
          Tweets are scraped to a local database and this site has no tracking (eg. Twitter's 'widget.js'). 
          Tweets and retweets by myself should show in full, all likes are truncated versions of original tweets. 
          The default page inlcudes tweets from today. 
          <br><br>
          Search for #{link_to("last year", scrapbook_path(date: @search_date - 1.year))}, #{link_to("two years ago", scrapbook_path(date: @search_date - 2.years))}.
        </p>
        <div class='input-group'>
          #{form_tag(scrapbook_path, method: :get, class: "w-100") do
            text_field_tag :term, (@term ? @term : '検索'), class: 'form-control'
          end}
        </div>
        <p class='p-2 text-center'>
          <b>#{@all_posts.length}</b> records found for the current selection.
        </p>
      </div>
    HTML
  end

end
