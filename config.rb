set :encoding, 'utf-8'
set :relative_links, true

# Support for browsing from the build folder.
set :strip_index_file,  false

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes
activate :rouge_syntax

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

page "/index.html", layout: :page

# Methods defined in the helpers block are available in templates
helpers do
  def shared_partial(*sources)
    sources.inject([]) do |combined, source|
      combined << partial("../shared/partials/#{source}")
    end.join
  end

  def pages
    require 'yaml'
    Pathname.new("shared/pages.yml").open { |file| YAML.load(file) }
  end

  def me
    require 'yaml'
    Pathname.new("shared/me.yml").open { |file| YAML.load(file) }
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'scripts'

set :images_dir, 'images'

# Allow shared assets folder to not be in source, thereby not dragging in every asset
after_configuration do
  sprockets.append_path "../shared/images"
  sprockets.append_path "../shared/scripts"
  # sprockets.append_path "../shared/fonts"
  sprockets.append_path "../shared/partials"
  sprockets.append_path "../shared/stylesheets"
end

# Build-specific configuration
configure :build do
  activate :sprockets

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Use relative URLs
  activate :relative_assets
end

set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true, :with_toc_data => true
set :markdown_engine, :redcarpet

activate :directory_indexes
