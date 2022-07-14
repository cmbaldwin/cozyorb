class AboutController < ApplicationController

  def index
    @post = Post.first
  end

end
