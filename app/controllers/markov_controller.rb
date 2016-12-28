class MarkovController < ApplicationController
  def fetch_twitter_chain
    if !params[:twitter_username].blank?
      user = User.find_or_create_by(twitter_username: params[:twitter_username])
      Markov.create_twitter_markov_chain(user)
      sentence = Markov.generate_sentence(user)
    else
      error = "Username Missing"
    end
    error = "Twitter user is private or invalid" if sentence == false
    respond_to do |format|
      format.html
      format.json { render json: {:sentence => sentence, :error => error} }
    end
  end

  private
    def markov_params
      params.require(:user).permit(:twitter_username)
    end
end
