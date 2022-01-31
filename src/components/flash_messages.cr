class FlashMessages < BaseComponent
  needs flashes : Lucky::FlashStore

  def render
    return unless flashes.any?

    div class: "w-full flex flex-col items-center" do
      flashes.each do |type, message|
        flash_message type, message
      end
    end
  end

  def flash_message(type, message)
    unique_id = "flash-message-#{Random::Secure.hex 6}"

    colors = case type
             when "success"
               "text-green-600 bg-green-100 border-green-600"
             when "failure"
               "text-red-500 bg-red-100 border-red-500"
             else
               "text-blue-600 bg-blue-100 border-blue-600"
             end

    div id: unique_id, class: "#{colors} flex justify-between w-1/2 px-4 py-2 mb-4 border rounded", flow_id: "flash" do
      div class: "flex" do
        span type.titleize, class: "font-bold mr-4"
        para message, class: "justify-self-start"
      end

      # close button
      div class: "cursor-pointer",
          onclick: "document.getElementById('#{unique_id}').remove()" do

        tag "svg",
              class: "fill-current h-6 w-6",
              role: "button",
              xmlns: "http://www.w3.org/2000/svg",
              viewBox:"0 0 20 20" do
          tag "title", "Close"
          tag "path",
            d: <<-SVG
              M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z
            SVG
        end
      end
    end
  end
end
