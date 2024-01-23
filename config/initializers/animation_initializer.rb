# config/initializers/animation_initializer.rb
system('node', Rails.root.join('scripts/runAnimation.js').to_s)
