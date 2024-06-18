module DiscussionsHelper

  # will display large numbers of views in a shortened fashion
  def view_count(count)
    if count > 1000
      rounded_count = sprintf "%.1f", (count.to_f/1000)
      rounded_count.gsub!(/\.0/, '')
      "#{rounded_count}K"
    else
      count
    end
  end

  # Discussions and Comments have content in one of the following formats:
  #   "Html", "TextEx", "Markdown", "Deleted"
  # given raw content, generate an output rails can use
  def format_post(format, raw_content, attachments, truncate = false)
    content = raw_content
    # any links to other forum posts need to be updated
    content.gsub!(/https:\/\/forum.biohack.me\/index.php\?p=\/discussion\/([0-9]+)\/[-_0-9A-z]+/) do |match|
      discussion_id = $1
      discussion_path(discussion_id, page: 1)
    end
    # ditto any links to uploaded forum media
    content.gsub!(/https:\/\/forum.biohack.me\/uploads\/editor\/([-_\/.A-z0-9]*)/) do |match|
      image_path = $1
      image_path("uploads/#{image_path}")
    end
    output = ''
    case format
    when 'Html'
      output = sanitize(auto_link(content, sanitize: false, html: { rel: 'nofollow' }), tags: %w(strong em a p br img ul ol li br div object param embed), attributes: %w(href src target rel alt width height class style name value type allowfullscreen allowScriptAccess))
    when 'TextEx'
      output = simple_format(auto_link(content, html: { rel: 'nofollow' }))
    when 'Markdown'
      options = {
        filter_html: true,
        hard_wrap: true,
        link_attributes: { rel: 'nofollow' },
        space_after_headers: true,
        fenced_code_blocks: true
      }
      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, autolink: true)
      output = markdown.render(content).html_safe
    when 'Deleted'
      output = content_tag(:em, "The user and all related content has been deleted.")
    else
      output = content_tag(:em, "Unknown post format!")
    end
    # auto link @usernames
    begin
      output.gsub!(/@([-_A-z0-9]+)/) do |match|
        username = $1
        disp_username = "@#{username}"
        user = User.where(name: username).first
        if user && !user.deleted? && !user.private?
          link_to disp_username, user_path(user.id)
        else
          disp_username
        end
      end
    rescue ArgumentError => e
      # some content was causing the @username match gsub to fail with
      # `ArgumentError (invalid byte sequence in UTF-8)` - don't make the app
      # crash over this, but log it
      logger.error "************ the following content failed with #{e.message} (#{e.class}):\n#{output}"
    end
    unless attachments.empty?
      output << "<ul class='attachments'>"
      attachments.each do |attachment|
        attachment_link = begin
                            asset_path(attachment.path)
                          rescue
                            false
                          end
        if attachment_link
          output << "<li id='#{attachment.id}'>"
          thumb_path = attachment.is_image? ? attachment.thumb_path : 'file.png'
          output << '<div class="preview">'
          output << link_to(image_tag(thumb_path, alt: attachment.name, title: attachment.name, width: 30, height: 30, loading: 'lazy'), attachment_link, target: '_blank')
          output << '</div>'
          output << '<div class="details">'
          output << link_to(attachment.name.truncate(24), attachment_link, target: '_blank')
          output << '<div class="file_size">'
          output << number_to_human_size(attachment.size)
          output << '</div>'
          output << '</div>'
          output << '</li>'
        end
      end
      output << "</ul>"
    end
    if truncate
      strip_tags(output).truncate(truncate).html_safe
    else
      output.html_safe
    end
  end

end
