class Home::Index < BrowserAction
  allow_guests

  get "/" do
    html Home::IndexPage
  end
end
