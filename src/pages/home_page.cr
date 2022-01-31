class Home::IndexPage < GuestLayout
  def content
    div do
      h1 "Welcome to the Home Page"
      para "This is the home page of the application"
    end
  end
end
