class ChatsController < ApplicationController
  before_action :authenticate_user!

  # Purely for rendering the chatroom
  def show
  end
end
