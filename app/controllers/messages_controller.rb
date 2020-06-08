class MessagesController < ApplicationController
    before_action :logged_in_user, only: [:create]

    def create
        if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
            @message = Message.create(params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
        else
            flash.now[:alert] = "Failed send message."
        end
        redirect_to "/rooms/#{@message.room_id}"
    end
end
