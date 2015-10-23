# Load settings
Figleaf::Settings.configure_with_auto_define do |s|
  s.env = "production"
  s.load_settings
end
Settings = Figleaf::Settings
