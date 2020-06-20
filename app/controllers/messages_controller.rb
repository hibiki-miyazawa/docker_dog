class MessagesController < ApplicationController
    before_action :logged_in_user, only: [:create]

    def create
        if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
            @message = Message.new(params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
            if @message.save
                redirect_to "/rooms/#{@message.room_id}"
                flash[:success] = "send completely"
            else
                redirect_to "/rooms/#{@message.room_id}"
                flash[:danger] = "failed to send message"
            end
        else
            redirect_to "/rooms/#{@message.room_id}"
            flash[:danger] = "failed to send message"
        end
    end
end
