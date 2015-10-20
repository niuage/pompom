# Load settings
Figleaf::Settings.configure_with_auto_define do |s|
  s.env = "development"
  s.load_settings
end
Settings = Figleaf::Settings
