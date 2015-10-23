require 'rubygems'
require 'bundler/setup' # Releasy requires require that your application uses bundler.
require 'releasy'

#<<<
Releasy::Project.new do
  name "PathOfMaps"
  version "0.1"
  verbose # Can be removed if you don't want to see all build messages.

  executable "main.rb"
  files ["config/**/*.yml", "config/**/*.rb", "lib/**/*.rb"]
  exposed_files ["README.md", "LICENSE.txt"]
  add_link "http://pathofmaps.herokuapp.com", "Path Of Maps website"
  add_link "https://github.com/niuage/pompom", "Github repo"
  exclude_encoding # Applications that don't use advanced encoding (e.g. Japanese characters) can save build size with this.

  # If building on a Windows machine, :windows_folder and/or :windows_installer are recommended.
  # add_build :windows_folder do
  #   # icon "media/icon.ico"
  #   executable_type :windows # Assuming you don't want it to run with a console window.
  #   add_package :exe # Windows self-extracting archive.
  # end

  # add_build :windows_installer do
  #   # icon "media/icon.ico"
  #   start_menu_group "Path Of Maps"
  #   readme "README.md" # User asked if they want to view readme after install.
  #   license "LICENSE.txt" # User asked to read this and confirm before installing.
  #   executable_type :windows # Assuming you don't want it to run with a console window.
  #   add_package :zip
  # end

  # If unable to build on a Windows machine, :windows_wrapped is the only choice.
  add_build :windows_wrapped do
    wrapper "wrappers/ruby-1.9.3-p551-i386-mingw32.7z" # Assuming this is where you downloaded this file.
    executable_type :windows # Assuming you don't want it to run with a console window.
    # exclude_tcl_tk # Assuming application doesn't use Tcl/Tk, then it can save a lot of size by using this.
    add_package :zip
  end

  add_deploy :local # Only deploy locally.
end
