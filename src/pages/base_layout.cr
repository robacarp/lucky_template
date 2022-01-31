abstract class BaseLayout
  include Foundation::LayoutHelpers::Authentication
  include Lucky::HTMLPage

  abstract def content

  def page_title
    "Welcome"
  end

  def render
    html_doctype

    html lang: "en" do
      head do
        utf8_charset
        title "My App - #{page_title}"
        css_link asset("css/app.css"), data_turbolinks_track: "reload"
        js_link asset("js/app.js"), defer: "true", data_turbolinks_track: "reload"
        meta name: "turbolinks-cache-control", content: "no-cache"
        csrf_meta_tags
        responsive_meta_tag
      end

      classes = [] of String
      classes << self.class.name.underscore.gsub(/::|_/, "-")
      classes << "max-w-screen-xl mx-auto"

      body class: classes.join(' ') do
        mount NavBar, current_user, admin_user
        mount FlashMessages, context.flash
        mount Foundation::SudoToolbar(User), current_user: current_user, admin_user: admin_user

        content
      end
    end
  end

  def fixed_width
    div class: "prose max-w-screen-xl w-full mx-auto h-screen p-4" do
      yield
    end
  end

  def centered
    div class: "w-full flex justify-center" do
      div do
        yield
      end
    end
  end

  def small_frame
    div class: "prose mx-auto w-full px-6 md:px-0 md:w-5/6" do
      yield
    end
  end

  def header_and_links
    div class: "md:flex md:justify-between md:items-end" do
      yield
    end

    hr class: "my-4"
  end

  def header_and_links(header_text : String)
    header_and_links do
      h3 header_text, class: "mb-0"
      div do
        yield
      end
    end
  end

  def header_and_links(header_text : String)
    header_and_links do
      h3 header_text, class: "mb-0"
    end
  end

  def middot_sep
    raw "&nbsp;&middot;&nbsp;"
  end
end
