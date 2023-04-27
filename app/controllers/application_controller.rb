class ApplicationController < ActionController::Base
  def admin?
    redirect_to root_path unless current_user.email == ENV['ADMIN']
  end

  def nostr
    name = params['name']
    name ||= 'cody'
    response.headers['Access-Control-Allow-Origin'] = '*' # CORS
    render json: {
      "names": {
        name => '27da3f032e0fea007947b0da12f1183630c5a2da79d7202b96f35f16ef6ce48e'
      }
    }
  end
end
