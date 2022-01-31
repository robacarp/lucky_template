class NavBar < BaseComponent
  needs current_user : User?
  needs admin_user : User?

  def render
    header class: "bg-blue-500 relative w-full px-6 mb-4 flex flex-wrap justify-between items-center" do
      link to: Home::Index, class: "flex items-center flex-shrink-0 mr-6 py-4 text-white font-semibold text-xl tracking-tight" do
        text "My Lucky App"
      end

      label class: "text-4xl leading-4 align-middle cursor-pointer block md:hidden", for: "hamburger-menu-toggle" do
        tag "svg", class: "fill-current h-4 w-4", viewBox: "0 0 20 20", xmlns: "http://www.w3.org/2000/svg" do
          title "Menu"
          tag "path", d: "M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"
        end
      end

      input type: "checkbox", id: "hamburger-menu-toggle", class: "hidden"

      nav class: "hidden w-full border-t border-slate-200 md:w-auto md:block md:border-0" do
        div class: "relative w-auto flex flex-col text-center md:flex md:flex-row md:justify-between md:items-center" do
          if current_user
            logged_in_menu
          else
            logged_out_menu
          end
        end
      end
    end
  end

  private def logged_in_menu
    menu_item "Account", to: My::Account::Show

    if admin_user
      label for: "admin-menu-toggle", class: "p-4 block md:p-2 cursor-pointer" do
        text "Admin"
      end
    end

    admin_menu if admin_user
  end

  private def logged_out_menu
    menu_item "Sign In", to: SignIns::New
  end

  private def admin_menu
    input type: "checkbox", id: "admin-menu-toggle", class: "hidden"
    nav class: "hidden w-full border-t border-slate-200 md:w-auto md:border-0 md:absolute md:top-12" do
      div class: "z-10 bg-gray-500 flex flex-col md:flex-row" do
        menu_item "Features", to: Admin::Features::Index
        menu_item "Users", to: Admin::Users::Index
      end
    end
  end

  private def menu_item(text, to action)
    link text, to: action, class: "p-4 inline-block md:p-2"
  end
end
