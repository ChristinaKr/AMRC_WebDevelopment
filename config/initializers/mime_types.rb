# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

# Mime::Type.register "application/xls", :xls
Mime::Type.register_alias "text/html", :phone
Mime::Type.register "text/csv", :csv
Mime::Type.register "*/*", :all