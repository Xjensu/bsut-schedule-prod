class TransferScheduleChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "transfer_schedule_#{params[:group_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
