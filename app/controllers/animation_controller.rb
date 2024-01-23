# app/controllers/animation_controller.rb
class AnimationController < ApplicationController
  include ExecjsHelper
  def show
    @user= current_user
    render 'animation'# Any logic or data you want to pass to the view
  end
end
# In your controller action
def generate_animation
  frames = []
  (0..100).each do |frame_number|
    # Replace this with your actual drawing/rendering logic
    frame_content = render_to_string(partial: 'partials/animation_frame', locals: { frame_number: frame_number })
    frames << frame_content
  end

  send_animation(frames)
end

def send_animation(frames)
  gif_io = Tempfile.new(['animation', '.gif'])
  gif_path = gif_io.path

  MiniMagick::Tool::Convert.new do |convert|
    convert.size '800x600'
    convert.delay '10'
    convert << '-'
    convert << gif_path
  end.call do |magick|
    frames.each { |frame| magick << 'gif:-' << frame }
  end

  send_file gif_path, type: 'image/gif', disposition: 'inline'
end
